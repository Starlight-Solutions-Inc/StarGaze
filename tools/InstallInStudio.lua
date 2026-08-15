local HttpService = game:GetService("HttpService")

local REPOSITORY = {
	Owner = "Starlight-Solutions-Inc",
	Name = "StarGaze",
	Branch = "main",
	SourcePath = "src/StarGaze",
}

local DEFAULTS = {
	InstallPath = "ReplicatedStorage.StarGaze",
	Mode = "Auto",
}

local function cloneDefaults(config)
	local result = {}

	for key, value in pairs(DEFAULTS) do
		result[key] = value
	end

	if type(config) == "table" then
		for key, value in pairs(config) do
			result[key] = value
		end
	end

	return result
end

local CONFIG = cloneDefaults(...)
CONFIG.Mode = string.lower(tostring(CONFIG.Mode or "Auto"))

if CONFIG.Mode ~= "auto" and CONFIG.Mode ~= "install" and CONFIG.Mode ~= "update" then
	error("[StarGaze] Mode must be Auto, Install, or Update.", 2)
end

if not HttpService.HttpEnabled then
	error("[StarGaze] HTTP requests are disabled. Enable Game Settings > Security > Allow HTTP Requests.", 2)
end

local function get(url)
	local success, result = pcall(function()
		return HttpService:GetAsync(url, false)
	end)

	if not success then
		return nil, tostring(result)
	end

	if type(result) ~= "string" or result == "" then
		return nil, "The response was empty."
	end

	return result
end

local function decode(source, name)
	local success, result = pcall(function()
		return HttpService:JSONDecode(source)
	end)

	if not success then
		error("[StarGaze] Could not decode " .. name .. ": " .. tostring(result), 2)
	end

	return result
end

local function resolvePath(path)
	assert(type(path) == "string" and path ~= "", "InstallPath must be a non-empty string.")

	local parts = {}
	for part in string.gmatch(path, "[^%.]+") do
		table.insert(parts, part)
	end

	assert(#parts >= 2, "InstallPath must include a parent and the StarGaze object name.")

	local current
	if parts[1] == "game" then
		current = game
	else
		current = game:FindFirstChild(parts[1])
	end

	assert(current, "Could not find the root of InstallPath: " .. parts[1])

	for index = 2, #parts - 1 do
		local nextObject = current:FindFirstChild(parts[index])

		if not nextObject then
			nextObject = Instance.new("Folder")
			nextObject.Name = parts[index]
			nextObject.Parent = current
		end

		current = nextObject
	end

	return current, parts[#parts]
end

local function createFolder(parent, path)
	local current = parent

	for part in string.gmatch(path, "[^/]+") do
		local existing = current:FindFirstChild(part)

		if existing then
			assert(existing:IsA("Folder"), part .. " exists but is not a Folder.")
			current = existing
		else
			local folder = Instance.new("Folder")
			folder.Name = part
			folder.Parent = current
			current = folder
		end
	end

	return current
end

local treeUrl = string.format(
	"https://api.github.com/repos/%s/%s/git/trees/%s?recursive=1",
	REPOSITORY.Owner,
	REPOSITORY.Name,
	REPOSITORY.Branch
)

local treeSource, treeError = get(treeUrl)

if not treeSource then
	error("[StarGaze] Could not read the GitHub repository tree: " .. tostring(treeError), 2)
end

local tree = decode(treeSource, "GitHub repository tree")
local sourcePrefix = REPOSITORY.SourcePath .. "/"
local files = {}

for _, entry in ipairs(tree.tree or {}) do
	if entry.type == "blob" and string.sub(entry.path, 1, #sourcePrefix) == sourcePrefix and string.sub(entry.path, -4) == ".lua" then
		table.insert(files, string.sub(entry.path, #sourcePrefix + 1))
	end
end

if #files == 0 then
	error("[StarGaze] No Lua files were found under " .. REPOSITORY.SourcePath, 2)
end

table.sort(files)

local parent, rootName = resolvePath(CONFIG.InstallPath)
local existing = parent:FindFirstChild(rootName)

if CONFIG.Mode == "install" and existing then
	error("[StarGaze] " .. CONFIG.InstallPath .. " already exists. Use Mode = \"Update\" or \"Auto\".", 2)
end

if CONFIG.Mode == "update" and not existing then
	error("[StarGaze] " .. CONFIG.InstallPath .. " does not exist. Use Mode = \"Install\" or \"Auto\".", 2)
end

if existing then
	print("[StarGaze] Updating " .. CONFIG.InstallPath .. "...")
	existing:Destroy()
else
	print("[StarGaze] Installing to " .. CONFIG.InstallPath .. "...")
end

local initPath = table.find(files, "init.lua")
assert(initPath, "[StarGaze] src/StarGaze/init.lua is missing from the repository.")

local initSource, initError = get(
	"https://raw.githubusercontent.com/"
	.. REPOSITORY.Owner .. "/"
	.. REPOSITORY.Name .. "/"
	.. REPOSITORY.Branch .. "/"
	.. REPOSITORY.SourcePath .. "/init.lua"
)

if not initSource then
	error("[StarGaze] Could not download init.lua: " .. tostring(initError), 2)
end

local root = Instance.new("ModuleScript")
root.Name = rootName
root.Source = initSource
root.Parent = parent

local installed = 0
local failed = 0

for _, relativePath in ipairs(files) do
	if relativePath ~= "init.lua" then
		local source, errorMessage = get(
			"https://raw.githubusercontent.com/"
			.. REPOSITORY.Owner .. "/"
			.. REPOSITORY.Name .. "/"
			.. REPOSITORY.Branch .. "/"
			.. REPOSITORY.SourcePath .. "/" .. relativePath
		)

		if source then
			local directory = relativePath:match("^(.*)/[^/]+$") or ""
			local filename = relativePath:match("([^/]+)$")
			local moduleName = filename:gsub("%.lua$", "")
			local moduleParent = createFolder(root, directory)

			local module = Instance.new("ModuleScript")
			module.Name = moduleName
			module.Source = source
			module.Parent = moduleParent

			installed += 1
			print("[StarGaze] Installed " .. relativePath)
		else
			failed += 1
			warn("[StarGaze] Failed " .. relativePath .. ": " .. tostring(errorMessage))
		end
	end
end

print("")
print("[StarGaze] Installation finished.")
print("[StarGaze] Location: " .. CONFIG.InstallPath)
print("[StarGaze] Modules installed: " .. tostring(installed))
print("[StarGaze] Modules failed: " .. tostring(failed))

if failed > 0 then
	warn("[StarGaze] The installation completed with errors. Review the Output window.")
else
	print("[StarGaze] StarGaze is ready to use.")
end
