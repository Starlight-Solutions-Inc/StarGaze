# StarGaze

A modular, modern Roblox UI framework for Luau by **Starlight Solutions, Inc.**

StarGaze is built for developers who want polished interfaces without turning every screen into a pile of one-off `Frame`, `TextButton`, and tween code. The framework separates the runtime, theme system, interactions, layout helpers, and UI components so projects can stay maintainable as they grow.

## Highlights

- Responsive, scale-first layout API
- Dark visual presets designed for Roblox interfaces
- Obsidian, Midnight, Carbon, and Violet themes
- Runtime theme registration and switching
- Glass and card surfaces
- Animated interaction states
- Buttons with hover and press treatment
- Toggles and checkboxes
- Radio-style controls
- Sliders and progress bars
- Dropdowns
- Text inputs
- Tabs
- Segmented controls
- Accordions
- Keybind controls
- Color picker palettes
- Notifications
- Confirmation dialogs
- Context menus
- Searchable command palette
- Tooltips
- Badges and dividers
- Responsive scaling helper
- Fluent component handles
- No external runtime dependencies

## Installation

The public API is intentionally simple:

```lua
local StarGaze = require(game.ReplicatedStorage.StarGaze)

local UI = StarGaze.create({
    Theme = "Obsidian",
})
```

The repository includes a `default.project.json` for Rojo and a Studio installer under `tools/`.

## Example

```lua
local StarGaze = require(game.ReplicatedStorage.StarGaze)

local UI = StarGaze.create({
    Theme = "Obsidian",
})

local window = UI:window({
    Title = "Control Center",
    Subtitle = "StarGaze",
    Size = UDim2.fromScale(0.62, 0.68),
})

local page = UI:createContainer(window.Content, {
    Size = UDim2.fromScale(1, 1),
    Color = "Background",
    Layout = {
        Padding = UDim.new(0, 8),
    },
})

UI:button(page, {
    Text = "Deploy",
    Color = "Accent",
    Size = UDim2.fromScale(1, 0.09),
    OnClick = function()
        UI:notify({
            Title = "Deployed",
            Text = "The operation completed successfully.",
            Type = "Success",
        })
    end,
})

UI:toggle(page, {
    Text = "Animated effects",
    Default = true,
})

UI:slider(page, {
    Text = "Intensity",
    Min = 0,
    Max = 100,
    Default = 65,
})
```

## Responsive layout

StarGaze avoids making the developer manually position every control with screen-specific pixel offsets. Public component defaults use relative `UDim2.fromScale` sizing and positioning, while the framework keeps small internal visual details isolated from layout decisions.

For larger experiences, attach the responsive helper to a root container:

```lua
UI:responsive(window.Instance, {
    BaseWidth = 1440,
    Min = 0.78,
    Max = 1.08,
})
```

## Themes

Built-in themes:

- `Obsidian`
- `Midnight`
- `Carbon`
- `Violet`

Register your own:

```lua
StarGaze.Themes.register("Aurora", {
    Background = Color3.fromRGB(8, 10, 16),
    Surface = Color3.fromRGB(15, 18, 27),
    SurfaceAlt = Color3.fromRGB(22, 26, 37),
    SurfaceRaised = Color3.fromRGB(29, 34, 47),
    Glass = Color3.fromRGB(19, 23, 34),
    Border = Color3.fromRGB(48, 60, 83),
    BorderSoft = Color3.fromRGB(32, 41, 57),
    Text = Color3.fromRGB(242, 247, 255),
    Subtext = Color3.fromRGB(146, 159, 181),
    Muted = Color3.fromRGB(96, 108, 130),
    Accent = Color3.fromRGB(78, 212, 191),
    AccentHover = Color3.fromRGB(112, 231, 214),
    AccentPressed = Color3.fromRGB(47, 174, 156),
    Success = Color3.fromRGB(77, 215, 140),
    Warning = Color3.fromRGB(246, 184, 68),
    Danger = Color3.fromRGB(241, 82, 88),
    Info = Color3.fromRGB(82, 161, 255),
})

UI:setTheme("Aurora")
```

## Repository layout

```text
StarGaze/
├── src/
│   └── StarGaze/
│       ├── Components/
│       ├── Core/
│       ├── Elements.lua
│       └── init.lua
├── example/
├── docs/
├── tools/
├── default.project.json
├── LICENSE
└── README.md
```

## License

StarGaze is free and open source under the MIT License.

Copyright (c) 2026 Starlight Solutions, Inc.

## Studio Bootstrap

StarGaze includes a bootstrap script for installing or updating the framework from GitHub. The bootstrap downloads the current installer and executes it in Studio.

Open `tools/StarGazeBootstrap.server.lua` and change `InstallPath` to the destination you want, for example `ReplicatedStorage.StarGaze` or `ReplicatedStorage.UI.StarGaze`. Then run the bootstrap from the Studio Command Bar.

```lua
local CONFIG = {
    InstallPath = "ReplicatedStorage.StarGaze",
}
```

The bootstrap uses the installer at:

`https://raw.githubusercontent.com/Starlight-Solutions-Inc/StarGaze/main/tools/InstallInStudio.lua`

The installer replaces an existing StarGaze installation at the selected path, so running the bootstrap again updates it. HTTP requests must be enabled in Game Settings. Because this workflow executes remotely fetched source, use a repository and branch you control and consider pinning releases for production.

For the normal in-game API:

```lua
local StarGaze = require(game.ReplicatedStorage.StarGaze)
```

## Studio Bootstrap Installer

StarGaze includes a small bootstrap that downloads the current installer from GitHub. The bootstrap does not contain the framework source itself. It loads `tools/InstallInStudio.lua`, and that installer downloads the current StarGaze source tree and places it into the configured Studio location.

Configure `tools/StarGazeBootstrap.server.lua`:

```lua
local CONFIG = {
    InstallPath = "ReplicatedStorage.StarGaze",
    Mode = "Auto",
    InstallerUrl = "https://raw.githubusercontent.com/Starlight-Solutions-Inc/StarGaze/main/tools/InstallInStudio.lua",
}
```

Full Installer:

```lua
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
	error("[StarGaze Bootstrap] loadstring is unavailable. Enable LoadStringEnabled in Studio/server settings.")
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
```

`Auto` installs a missing copy or replaces the existing copy with the current GitHub version. `Install` only installs when the destination does not exist. `Update` only updates an existing installation.

Run the bootstrap from Studio with HTTP requests enabled.


## Customization

StarGaze exposes a runtime settings system so a project can control the visual language from one place.

```lua
UI:configure({
\tDensity = "Compact",
\tStyle = "Glass",
\tTemplate = "Inspector",
\tAnimation = true,
\tAnimationSpeed = 0.14,
\tHover = true,
\tPress = true,
\tTooltips = true,
\tShadows = true,
\tTextScale = 0.95,
\tSidebarWidth = 0.2,
})
```

Built-in style profiles include `Soft`, `Sharp`, `Glass`, and `Dense`. Built-in templates include `MinimalWindow`, `Dashboard`, `CompactPanel`, and `Inspector`.

## Plugins

Plugins can add behavior, commands, components, theme hooks, or other project-specific functionality without editing the StarGaze core.

```lua
UI:registerPlugin({
\tName = "DeveloperTools",
\tSetup = function(context)
\t\tlocal runtime = context.Runtime
\t\truntime:notify({
\t\t\tTitle = "Developer Tools",
\t\t\tText = "Plugin loaded.",
\t\t\tType = "Info",
\t\t})
\tend,
\tDestroy = function(context)
\tend,
})
```

Plugins are isolated from the built-in component implementation and can store their own state through the supplied context.

## Custom styles and templates

```lua
UI:registerStyle("Studio", {
\tRadius = 8,
\tStrokeTransparency = 0.2,
\tHoverStrength = 0.04,
\tPressScale = 0.985,
\tShadow = true,
})

UI:registerTemplate("ControlPanel", {
\tWindow = {
\t\tSize = UDim2.fromScale(0.4, 0.7),
\t\tCornerRadius = 10,
\t},
\tContent = {
\t\tPadding = 0.018,
\t},
})
```
