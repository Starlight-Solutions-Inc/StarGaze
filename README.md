# StarGaze

**StarGaze** is a modular Roblox UI framework built by **Starlight Solutions, Inc.**

It is intended to make polished Roblox interfaces easier to build without forcing every project into the same layout or visual style. The framework is organized around reusable components, theme tokens, presets, interaction helpers, and a small fluent API.

## Highlights

- Modular Luau architecture
- Built-in dark themes: Obsidian, Midnight, Carbon, Violet
- Custom theme registration
- Cards and glass-style surfaces
- Interactive buttons with hover and press behavior
- Toggles
- Sliders
- Dropdowns
- Tabs
- Windows
- Notifications
- Confirmation dialogs
- Badges
- Dividers
- Tooltips
- Runtime theme switching
- Fluent component handles
- No external dependencies
- Rojo-compatible project structure

## Project layout

```text
StarGaze/
├── src/
│   └── StarGaze/
│       ├── Components/
│       │   ├── Badge.lua
│       │   ├── Button.lua
│       │   ├── Confirm.lua
│       │   ├── Divider.lua
│       │   ├── Dropdown.lua
│       │   ├── Notification.lua
│       │   ├── Slider.lua
│       │   ├── Tabs.lua
│       │   ├── Toggle.lua
│       │   ├── Tooltip.lua
│       │   └── Window.lua
│       ├── Elements.lua
│       ├── Interaction.lua
│       ├── Presets.lua
│       ├── Runtime.lua
│       ├── Themes.lua
│       ├── Utils.lua
│       └── init.lua
├── example/
│   └── Example.client.lua
├── default.project.json
├── LICENSE
└── README.md
```

## Installation

### Rojo

Clone the repository and build the project with Rojo. `default.project.json` maps the framework into `ReplicatedStorage.StarGaze`.

### Manual Roblox Studio installation

Place the `StarGaze` folder from `src` into `ReplicatedStorage`.

## Quick start

```lua
local StarGaze = require(game.ReplicatedStorage.StarGaze)

local UI = StarGaze.new({
    Theme = "Obsidian",
})

local window = UI:window({
    Title = "My Interface",
    Subtitle = "Powered by StarGaze",
    Size = UDim2.fromOffset(650, 420),
})

local content = UI:createContainer(window.Content, {
    Size = UDim2.new(1, -24, 1, -24),
    Position = UDim2.fromOffset(12, 12),
    Color = "Background",
    Layout = {
        Padding = UDim.new(0, 8),
    },
})

UI:button(content, {
    Text = "Click Me",
    OnClick = function()
        UI:notify({
            Title = "StarGaze",
            Text = "The button was pressed.",
            Type = "Success",
        })
    end,
})
```

## Themes

StarGaze ships with four presets:

`Obsidian` · `Midnight` · `Carbon` · `Violet`

Custom themes can be registered through `StarGaze.Themes.register` and selected at runtime with `UI:setTheme`.

## Design philosophy

StarGaze intentionally keeps the component API small while allowing components to expose handles for state changes. This lets a game create its own layout and behavior instead of depending on a large prebuilt UI template.

## License

MIT License. See `LICENSE`.
