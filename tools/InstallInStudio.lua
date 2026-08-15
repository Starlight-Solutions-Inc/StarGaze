local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local OWNER = "Starlight-Solutions-Inc"
local REPOSITORY = "StarGaze"
local BRANCH = "main"
local BASE = "https://raw.githubusercontent.com/" .. OWNER .. "/" .. REPOSITORY .. "/" .. BRANCH .. "/src/StarGaze"

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

local old = ReplicatedStorage:FindFirstChild("StarGaze")
if old then old:Destroy() end

local root = Instance.new("ModuleScript")
root.Name = "StarGaze"
root.Source = [[
local Runtime = require(script.Core.Runtime)
local Themes = require(script.Core.Themes)
local Presets = require(script.Core.Presets)
local StarGaze = {Version = "2.0.0", Themes = Themes, Presets = Presets}
function StarGaze.create(options) return Runtime.new(options) end
return StarGaze
]]
root.Parent = ReplicatedStorage

local function folder(path)
	local current = root
	for part in string.gmatch(path, "[^/]+") do
		local found = current:FindFirstChild(part)
		if not found then
			found = Instance.new("Folder")
			found.Name = part
			found.Parent = current
		end
		current = found
	end
	return current
end

for _, path in ipairs(files) do
	local ok, source = pcall(function()
		return HttpService:GetAsync(BASE .. "/" .. path, false)
	end)
	if ok and source ~= "" then
		local directory = path:match("^(.*)/[^/]+$") or ""
		local name = path:match("([^/]+)$"):gsub("%.lua$", "")
		local module = Instance.new("ModuleScript")
		module.Name = name
		module.Source = source
		module.Parent = folder(directory)
		print("[StarGaze] Installed", path)
	else
		warn("[StarGaze] Failed", path, source)
	end
end

print("[StarGaze] Installed to ReplicatedStorage.StarGaze")
