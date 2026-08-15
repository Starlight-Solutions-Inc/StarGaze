local HttpService = game:GetService("HttpService")

local OWNER = "Starlight-Solutions-Inc"
local REPOSITORY = "StarGaze"
local BRANCH = "main"
local SOURCE_PATH = "src/StarGaze"

local INSTALL_PATH = rawget(_G, "StarGazeInstallPath") or "ReplicatedStorage.StarGaze"

local BASE_URL = string.format(
	"https://raw.githubusercontent.com/%s/%s/%s/%s",
	OWNER,
	REPOSITORY,
	BRANCH,
	SOURCE_PATH
)

local files = {
	"Core/Runtime.lua",
	"Core/Utils.lua",
	"Core/Themes.lua",
	"Core/Presets.lua",
	"Core/Interaction.lua",
	"Core/Responsive.lua",
	"Elements.lua",
	"Components/Button.lua",
	"Components/Window.lua",
	"Components/Toggle.lua",
	"Components/Checkbox.lua",
	"Components/Radio.lua",
	"Components/Slider.lua",
	"Components/Input.lua",
	"Components/Progress.lua",
	"Components/Dropdown.lua",
	"Components/Tabs.lua",
	"Components/Badge.lua",
	"Components/Divider.lua",
	"Components/Notification.lua",
	"Components/Tooltip.lua",
	"Components/Confirm.lua",
	"Components/ContextMenu.lua",
	"Components/CommandPalette.lua",
	"Components/Keybind.lua",
	"Components/Segmented.lua",
	"Components/Accordion.lua",
	"Components/ColorPicker.lua",
}

local function getSource(url)
	local success, result = pcall(function()
		return HttpService:GetAsync(url, false)
	end)

	if not success then
		return nil, tostring(result)
	end

	if type(result) ~= "string" or result == "" then
		return nil, "GitHub returned an empty response."
	end

	return result
end

local function splitPath(path)
	local parts = {}

	for part in string.gmatch(path, "[^%.]+") do
		table.insert(parts, part)
	end

	return parts
end

local function resolveParent(path)
	local parts = splitPath(path)

	assert(#parts >= 2, "Install path must contain a parent and final object name.")

	local current

	if parts[1] == "game" then
		current = game
	else
		current = game:FindFirstChild(parts[1])
	end

	assert(current, "Could not find install root: " .. parts[1])

	for index = 2, #parts - 1 do
		current = current:FindFirstChild(parts[index])
		assert(current, "Could not find install path: " .. table.concat(parts, ".", 1, index))
	end

	return current, parts[#parts]
end

local function getOrCreateFolder(parent, path)
	if path == "" then
		return parent
	end

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

assert(HttpService.HttpEnabled, "[StarGaze] HTTP requests are disabled.")

local parent, rootName = resolveParent(INSTALL_PATH)
local old = parent:FindFirstChild(rootName)

if old then
	print("[StarGaze] Updating " .. INSTALL_PATH)
	old:Destroy()
else
	print("[StarGaze] Installing to " .. INSTALL_PATH)
end

local root = Instance.new("ModuleScript")
root.Name = rootName
root.Source = [[
local Runtime = require(script.Core.Runtime)
local Themes = require(script.Core.Themes)
local Presets = require(script.Core.Presets)

local StarGaze = {
	Version = "2.0.0",
	Themes = Themes,
	Presets = Presets,
}

function StarGaze.create(options)
	return Runtime.new(options)
end

return StarGaze
]]
root.Parent = parent

local installed = 0
local failed = 0

for _, path in ipairs(files) do
	local source, errorMessage = getSource(BASE_URL .. "/" .. path)

	if not source then
		failed += 1
		warn("[StarGaze] Failed: " .. path)
		warn("[StarGaze] " .. errorMessage)
		continue
	end

	local directory = path:match("^(.*)/[^/]+$") or ""
	local filename = path:match("([^/]+)$")
	local moduleName = filename:gsub("%.lua$", "")
	local moduleParent = getOrCreateFolder(root, directory)

	local module = Instance.new("ModuleScript")
	module.Name = moduleName
	module.Source = source
	module.Parent = moduleParent

	installed += 1
	print("[StarGaze] Installed " .. path)
end

print("")
print("StarGaze installation complete")
print("Location: " .. INSTALL_PATH)
print("Modules: " .. installed)
print("Failed: " .. failed)

if failed > 0 then
	warn("[StarGaze] Some modules could not be installed. Check the Output window.")
end
