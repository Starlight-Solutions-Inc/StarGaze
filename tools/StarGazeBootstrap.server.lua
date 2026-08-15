local HttpService = game:GetService("HttpService")
local ServerScriptService = game:GetService("ServerScriptService")

local CONFIG = {
	InstallPath = "ReplicatedStorage.StarGaze",
	InstallerUrl = "https://raw.githubusercontent.com/Starlight-Solutions-Inc/StarGaze/main/tools/InstallInStudio.lua",
}

assert(HttpService.HttpEnabled, "[StarGaze] Enable Game Settings > Security > Allow HTTP Requests.")
assert(ServerScriptService.LoadStringEnabled, "[StarGaze] Enable ServerScriptService.LoadStringEnabled before using this bootstrapper.")

local success, source = pcall(function()
	return HttpService:GetAsync(CONFIG.InstallerUrl, false)
end)

if not success then
	error("[StarGaze] Could not download the installer: " .. tostring(source), 2)
end

if source == "" then
	error("[StarGaze] The installer returned an empty response.", 2)
end

local installer, compileError = loadstring(source, "StarGazeInstaller")

if not installer then
	error("[StarGaze] Installer compilation failed: " .. tostring(compileError), 2)
end

_G.StarGazeInstallPath = CONFIG.InstallPath

local ran, runtimeError = pcall(installer)

_G.StarGazeInstallPath = nil

if not ran then
	error("[StarGaze] Installer failed: " .. tostring(runtimeError), 2)
end

print("[StarGaze] Bootstrap finished. Installed at " .. CONFIG.InstallPath)
