local HttpService = game:GetService("HttpService")

local CONFIG = {
	InstallPath = "ReplicatedStorage.StarGaze",
	Mode = "Auto",
	InstallerUrl = "https://raw.githubusercontent.com/Starlight-Solutions-Inc/StarGaze/main/tools/InstallInStudio.lua",
}

local function fail(message)
	error("[StarGaze] " .. message, 2)
end

if not HttpService.HttpEnabled then
	fail("HTTP requests are disabled. Enable Game Settings > Security > Allow HTTP Requests.")
end

local success, source = pcall(function()
	return HttpService:GetAsync(CONFIG.InstallerUrl, false)
end)

if not success then
	fail("Could not download the installer from GitHub: " .. tostring(source))
end

if type(source) ~= "string" or source == "" then
	fail("GitHub returned an empty installer.")
end

local installer, compileError = loadstring(source, "StarGazeInstaller")

if not installer then
	fail("The GitHub installer could not be compiled: " .. tostring(compileError))
end

local ran, result = pcall(installer, CONFIG)

if not ran then
	fail("The GitHub installer failed: " .. tostring(result))
end

print("[StarGaze] Bootstrap completed.")
