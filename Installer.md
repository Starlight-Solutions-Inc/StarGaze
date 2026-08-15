## Installation

StarGaze can be installed directly into your Roblox experience using the installer below. The installer automatically downloads the framework from the official GitHub repository and recreates the required module structure inside `ReplicatedStorage`.

### Requirements

Before running the installer:

* Roblox Studio
* **HTTP Requests** enabled
* Access to the Roblox Studio **Command Bar**

Enable HTTP requests under:

**Game Settings → Security → Allow HTTP Requests**

### Quick Install

Open the **Command Bar** in Roblox Studio, paste the installer below, and run it.

```lua
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local OWNER = "Starlight-Solutions-Inc"
local REPOSITORY = "StarGaze"
local BRANCH = "main"

local BASE_URL = string.format(
	"https://raw.githubusercontent.com/%s/%s/%s/src/StarGaze",
	OWNER,
	REPOSITORY,
	BRANCH
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

local function log(message)
	print("[StarGaze] " .. message)
end

local function fail(message)
	warn("[StarGaze] " .. message)
end

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

local function getOrCreateFolder(parent, path)
	local current = parent

	if path == "" then
		return current
	end

	for part in string.gmatch(path, "[^/]+") do
		local existing = current:FindFirstChild(part)

		if existing then
			if not existing:IsA("Folder") then
				return nil, part .. " already exists and is not a Folder."
			end

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

log("Starting installation...")
log("Source: " .. OWNER .. "/" .. REPOSITORY .. "@" .. BRANCH)

if not HttpService.HttpEnabled then
	fail("HTTP requests are disabled.")
	fail("Enable Game Settings > Security > Allow HTTP Requests.")
	return
end

local existing = ReplicatedStorage:FindFirstChild("StarGaze")

if existing then
	log("Removing existing StarGaze installation...")
	existing:Destroy()
end

local root = Instance.new("ModuleScript")
root.Name = "StarGaze"
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

root.Parent = ReplicatedStorage

log("Created ReplicatedStorage.StarGaze")

local installed = 0
local failed = 0

for _, path in ipairs(files) do
	local url = BASE_URL .. "/" .. path

	log("Downloading " .. path)

	local source, errorMessage = getSource(url)

	if not source then
		failed += 1
		fail("Could not download " .. path)
		fail("URL: " .. url)
		fail("Reason: " .. errorMessage)
		continue
	end

	local directory = path:match("^(.*)/[^/]+$") or ""
	local filename = path:match("([^/]+)$")
	local name = filename:gsub("%.lua$", "")

	local parent, folderError = getOrCreateFolder(root, directory)

	if not parent then
		failed += 1
		fail("Could not create " .. directory)
		fail(folderError)
		continue
	end

	local existingModule = parent:FindFirstChild(name)

	if existingModule then
		existingModule:Destroy()
	end

	local module = Instance.new("ModuleScript")
	module.Name = name
	module.Source = source
	module.Parent = parent

	installed += 1
	log("Installed " .. path)
end

print("")
print("==========================================")
print("          StarGaze Installation")
print("==========================================")
print("Installed modules: " .. installed)
print("Failed modules:    " .. failed)
print("Location:          ReplicatedStorage.StarGaze")
print("")

if failed == 0 then
	log("Installation completed successfully.")
	log("Usage:")
	print("")
	print('local StarGaze = require(game.ReplicatedStorage.StarGaze)')
else
	fail("Installation completed with " .. failed .. " failure(s).")
	fail("Check the Output window above for the affected files.")
end
```

### What the Installer Does

The installer handles the entire setup automatically:

| Step | Action                                       |
| ---- | -------------------------------------------- |
| 1    | Verifies that HTTP requests are enabled      |
| 2    | Connects to the configured GitHub repository |
| 3    | Removes any existing `StarGaze` installation |
| 4    | Creates `ReplicatedStorage.StarGaze`         |
| 5    | Creates the required folder structure        |
| 6    | Downloads each StarGaze module               |
| 7    | Installs the downloaded modules              |
| 8    | Reports successful and failed installations  |

### Installation Structure

After installation, the framework will be organized as follows:

```text
ReplicatedStorage
└── StarGaze
    ├── Core
    │   ├── Runtime
    │   ├── Utils
    │   ├── Themes
    │   ├── Presets
    │   ├── Interaction
    │   └── Responsive
    │
    ├── Components
    │   ├── Button
    │   ├── Window
    │   ├── Toggle
    │   ├── Checkbox
    │   ├── Radio
    │   ├── Slider
    │   ├── Input
    │   ├── Progress
    │   ├── Dropdown
    │   ├── Tabs
    │   ├── Badge
    │   ├── Divider
    │   ├── Notification
    │   ├── Tooltip
    │   ├── Confirm
    │   ├── ContextMenu
    │   ├── CommandPalette
    │   ├── Keybind
    │   ├── Segmented
    │   ├── Accordion
    │   └── ColorPicker
    │
    ├── Elements
    └── StarGaze
```

### Updating

To update StarGaze, simply run the installer again.

The installer replaces the existing `ReplicatedStorage.StarGaze` installation with the latest version available from the configured branch.

> [!WARNING]
> Running the installer removes the existing `StarGaze` instance first. Any modifications made directly to the installed modules will be lost.

### Troubleshooting

#### `HTTP requests are disabled`

Go to:

**Game Settings → Security → Allow HTTP Requests**

Enable the setting and run the installer again.

#### A module fails to download

Check the **Output** window for the failed file and its corresponding GitHub URL.

Common causes include:

* The file was moved or renamed.
* The configured branch does not contain the file.
* The repository path is incorrect.
* Roblox cannot access the requested resource.

#### Installation reports failures

The installer continues processing the remaining files when an individual download fails. Review the Output window to identify the affected modules, resolve the issue, and run the installer again.

### Installed Version

The installer currently installs **StarGaze `2.0.0`** from the `main` branch.
