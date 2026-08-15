local HttpService = game:GetService("HttpService")

local CONFIG = {
	InstallPath = "ReplicatedStorage.StarGaze",
	Mode = "Auto",
	InstallerUrl = "https://raw.githubusercontent.com/Starlight-Solutions-Inc/StarGaze/main/tools/InstallInStudio.lua",
}

if not HttpService.HttpEnabled then
	error("[StarGaze Bootstrap] HTTP requests are disabled. Enable Game Settings > Security > Allow HTTP Requests.")
end

local success, source = pcall(function()
	return HttpService:GetAsync(CONFIG.InstallerUrl, false)
end)

if not success then
	error("[StarGaze Bootstrap] Could not download the installer:\n" .. tostring(source))
end

if type(source) ~= "string" or source == "" then
	error("[StarGaze Bootstrap] GitHub returned an empty installer.")
end

if type(loadstring) ~= "function" then
	error("[StarGaze Bootstrap] loadstring is unavailable in this Studio environment.")
end

local installer, compileError = loadstring(source)
if not installer then
	error("[StarGaze Bootstrap] The GitHub installer could not be compiled:\n" .. tostring(compileError))
end

local ran, runtimeError = pcall(installer, {
	InstallPath = CONFIG.InstallPath,
	Mode = CONFIG.Mode,
})

if not ran then
	error("[StarGaze Bootstrap] The installer failed:\n" .. tostring(runtimeError))
end

print("[StarGaze Bootstrap] StarGaze installation/update completed.")
