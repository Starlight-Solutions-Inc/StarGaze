StarGaze

StarGaze is a modular, highly customizable UI framework for Roblox built by Starlight Solutions, Inc.

It is designed for developers who want polished interfaces without having to build the underlying UI systems from scratch. StarGaze provides reusable components, themes, templates, presets, animations, responsive sizing, plugins, overlays, and a configurable styling system.

Features
Modular Luau architecture
Built-in dark themes
Custom theme support
Multiple visual styles
Custom style registration
UI templates
Reusable presets
Custom preset registration
Responsive scaling
Configurable density
Global animation settings
Hover and press interactions
Configurable corner radii
Custom fonts
Text scaling
Glass-style surfaces
Cards and panels
Buttons
Toggles
Checkboxes
Radio controls
Sliders
Progress bars
Inputs
Dropdowns
Tabs
Segmented controls
Accordions
Keybind controls
Color pickers
Notifications
Confirmation dialogs
Context menus
Command palette
Tooltips
Badges
Dividers
Windows
Plugin system
Runtime configuration
Runtime theme switching
No external dependencies
Installation

StarGaze includes a bootstrap installer that downloads the current installer from GitHub. The installer then downloads the framework files and creates or updates the StarGaze installation in your game.

This means users do not need to manually copy every ModuleScript into ReplicatedStorage.

Requirements

Before using the bootstrap, enable HTTP requests in Roblox Studio.

Go to:

Game Settings
└── Security
    └── Allow HTTP Requests = ON

The bootstrap also uses loadstring. Run it in an environment where loadstring is permitted.

For a normal server-side installation, use a Script in ServerScriptService.

Bootstrap Installer

Create a Script in ServerScriptService, then paste the following:

local HttpService = game:GetService("HttpService")

local CONFIG = {
	InstallPath = "ReplicatedStorage.StarGaze",
	Mode = "Auto",
	InstallerUrl = "https://raw.githubusercontent.com/Starlight-Solutions-Inc/StarGaze/main/tools/InstallInStudio.lua",
}

local function request(url)
	local success, result = pcall(function()
		return HttpService:GetAsync(url, false)
	end)

	if not success then
		error("[StarGaze Bootstrap] Failed to download installer:\n" .. tostring(result))
	end

	if not result or result == "" then
		error("[StarGaze Bootstrap] Installer returned an empty response.")
	end

	return result
end

if not HttpService.HttpEnabled then
	error("[StarGaze Bootstrap] HTTP requests are disabled. Enable Game Settings > Security > Allow HTTP Requests.")
end

local source = request(CONFIG.InstallerUrl)

if type(loadstring) ~= "function" then
	error("[StarGaze Bootstrap] loadstring is unavailable in this environment.")
end

local installer, compileError = loadstring(source)

if not installer then
	error("[StarGaze Bootstrap] Installer could not be compiled:\n" .. tostring(compileError))
end

local success, runtimeError = pcall(function()
	installer({
		InstallPath = CONFIG.InstallPath,
		Mode = CONFIG.Mode,
	})
end)

if not success then
	error("[StarGaze Bootstrap] Installer failed:\n" .. tostring(runtimeError))
end

print("[StarGaze Bootstrap] Installation/update completed.")
Installation Modes
Auto

Creates StarGaze when it does not exist and updates an existing installation.

Mode = "Auto"
Install

Only installs StarGaze when it is not already present.

Mode = "Install"
Update

Only updates an existing StarGaze installation.

Mode = "Update"
Custom Installation Location

The installation path is controlled by:

InstallPath = "ReplicatedStorage.StarGaze"

The default installation creates:

ReplicatedStorage
└── StarGaze

You can change it to another location.

For example:

InstallPath = "ReplicatedStorage.UI.StarGaze"

creates:

ReplicatedStorage
└── UI
    └── StarGaze

Another example:

InstallPath = "ServerStorage.StarGaze"

The installer automatically creates missing intermediate folders.

Using StarGaze

After installation, require the root ModuleScript:

local StarGaze = require(game.ReplicatedStorage.StarGaze)

Create a runtime:

local UI = StarGaze.create({
	Theme = "Obsidian",
})

Create a window:

local window = UI:window({
	Name = "Main",
	Title = "My Interface",
	Subtitle = "Powered by StarGaze",
	Size = UDim2.fromScale(0.65, 0.7),
	Position = UDim2.fromScale(0.5, 0.5),
})

Create a component:

UI:button(window.Content, {
	Text = "Click Me",

	OnClick = function()
		UI:notify({
			Title = "StarGaze",
			Text = "Button activated.",
			Type = "Success",
		})
	end,
})
Themes

StarGaze includes several built-in themes.

Obsidian
Midnight
Carbon
Violet

Use a theme when creating the runtime:

local UI = StarGaze.create({
	Theme = "Midnight",
})

Or change it later:

UI:setTheme("Violet")
Custom Themes

Register your own theme:

StarGaze.Themes.register("Custom", {
	Background = Color3.fromRGB(8, 8, 10),
	Surface = Color3.fromRGB(15, 15, 19),
	SurfaceAlt = Color3.fromRGB(23, 23, 29),
	Glass = Color3.fromRGB(23, 23, 29),
	Card = Color3.fromRGB(19, 19, 24),

	Border = Color3.fromRGB(48, 48, 58),

	Text = Color3.fromRGB(245, 245, 248),
	Subtext = Color3.fromRGB(150, 150, 162),

	Accent = Color3.fromRGB(145, 95, 255),
	AccentAlt = Color3.fromRGB(190, 150, 255),

	Success = Color3.fromRGB(76, 210, 130),
	Warning = Color3.fromRGB(245, 183, 66),
	Danger = Color3.fromRGB(240, 82, 86),
	Info = Color3.fromRGB(82, 156, 255),
})

Then:

UI:setTheme("Custom")
Runtime Configuration

StarGaze exposes global settings so an application can have a consistent visual language.

Example:

UI:configure({
	Density = "Compact",

	Style = "Glass",
	Template = "Dashboard",

	Animation = true,
	AnimationSpeed = 0.14,

	Hover = true,
	Press = true,

	Tooltips = true,
	Shadows = true,

	TextScale = 0.95,

	SidebarWidth = 0.2,
})

The exact settings available may vary as the framework evolves.

Built-In Styles

StarGaze provides visual styles that can be used as a starting point.

Soft
Sharp
Glass
Dense

Example:

UI:configure({
	Style = "Glass",
})
Custom Styles

Create your own style:

UI:registerStyle("Studio", {
	Radius = 8,
	StrokeTransparency = 0.2,
	HoverStrength = 0.04,
	PressScale = 0.985,
	Shadow = true,
})

Then use it:

UI:configure({
	Style = "Studio",
})
Templates

StarGaze includes reusable layout templates.

Examples include:

MinimalWindow
Dashboard
CompactPanel
Inspector

Example:

UI:configure({
	Template = "Dashboard",
})

Templates are intended to provide a starting structure while still allowing individual components to be customized.

Plugins

StarGaze supports custom plugins so developers can extend the framework without modifying its core source.

Example:

UI:registerPlugin({
	Name = "DeveloperTools",

	Setup = function(context)
		local runtime = context.Runtime

		runtime:notify({
			Title = "Developer Tools",
			Text = "Plugin loaded.",
			Type = "Info",
		})
	end,

	Destroy = function(context)
	end,
})

Plugins can be used to add framework-specific behavior, tools, integrations, components, or application features.

Presets

StarGaze contains reusable visual presets.

Example:

local button = UI:button(parent, {
	Text = "Primary Action",
})

Presets can also be customized and registered for projects that need a consistent design system.

Components

StarGaze currently provides components including:

Window
Button
Toggle
Checkbox
Radio
Slider
Progress
Input
Dropdown
Tabs
Segmented
Accordion
Keybind
ColorPicker
Badge
Divider
Notification
Tooltip
Confirm
ContextMenu
CommandPalette

Every component is implemented as a separate module, allowing the framework to grow without turning into a single monolithic script.

Responsive UI

StarGaze is designed around scale-based layouts where practical rather than relying heavily on fixed pixel offsets.

A responsive component can be configured with:

UI:responsive(window.Instance, {
	BaseWidth = 1440,
	Min = 0.8,
	Max = 1.05,
})

This allows the UI to adapt to different screen sizes while retaining its intended proportions.

Example

A basic interface:

local StarGaze = require(game.ReplicatedStorage.StarGaze)

local UI = StarGaze.create({
	Theme = "Obsidian",
})

local window = UI:window({
	Title = "Example",
	Subtitle = "StarGaze UI",
	Size = UDim2.fromScale(0.65, 0.7),
	Position = UDim2.fromScale(0.5, 0.5),
})

local content = UI:createContainer(window.Content, {
	Size = UDim2.fromScale(0.94, 0.92),
	Position = UDim2.fromScale(0.03, 0.04),

	Layout = {
		Padding = UDim.new(0.015, 0),
	},
})

UI:createText(content, "Welcome", {
	Size = UDim2.fromScale(1, 0.07),
	TextSize = 20,
})

UI:toggle(content, {
	Text = "Enable feature",
	Default = true,
})

UI:slider(content, {
	Text = "Volume",
	Min = 0,
	Max = 100,
	Default = 75,
})

UI:button(content, {
	Text = "Apply",

	OnClick = function()
		UI:notify({
			Title = "Applied",
			Text = "Your settings have been updated.",
			Type = "Success",
		})
	end,
})
Updating StarGaze

The bootstrap uses the GitHub installer:

https://raw.githubusercontent.com/Starlight-Solutions-Inc/StarGaze/main/tools/InstallInStudio.lua

When the bootstrap runs with:

Mode = "Auto"

it will install StarGaze when it is missing and update the existing installation when it is already present.

This allows projects to update StarGaze without manually copying every ModuleScript.

For production projects, consider pinning installations to a specific release or commit instead of automatically pulling mutable main content.

Development

The repository is structured for modular development:

StarGaze/
├── src/
│   └── StarGaze/
│       ├── Core/
│       ├── Components/
│       ├── Elements.lua
│       └── init.lua
├── example/
├── docs/
├── tools/
├── default.project.json
├── LICENSE
└── README.md

The project can be used with Rojo for development and synchronization with Roblox Studio.

License

StarGaze is released under the MIT License.

Copyright (c) 2026 Starlight Solutions, Inc.

This allows developers to use, modify, redistribute, and incorporate StarGaze into their own projects, including commercial projects, subject to the terms of the MIT License.
