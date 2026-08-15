# StarGaze API

## Runtime

```lua
local StarGaze = require(game.ReplicatedStorage.StarGaze)
local UI = StarGaze.create({Theme = "Obsidian"})
```

Core methods include:

```text
create
setTheme
onThemeChanged
configure
setting
registerPlugin
unregisterPlugin
getPlugin
listPlugins
registerStyle
applyStyle
registerTemplate
template
responsive
destroy
```

## Layout

```text
createFrame
createText
createContainer
card
glass
```

## Components

```text
window
button
toggle
checkbox
radio
slider
progress
input
dropdown
tabs
segmented
accordion
keybind
colorPicker
badge
divider
notification
notify
confirm
contextMenu
commandPalette
tooltip
```

Most interactive components return a component object with methods such as `set`, `get`, `changed`, `open`, `close`, or `toggle`, depending on the component.

## Responsive sizing

Use scale-based `UDim2` values where possible. The responsive helper applies a bounded `UIScale` to a root element and tracks viewport changes.

```lua
UI:responsive(window.Instance, {
	BaseWidth = 1440,
	Min = 0.78,
	Max = 1.04,
})
```


## Scrolling containers

```lua
local content = UI:scroll(parent, {
    Size = UDim2.fromScale(1, 1),
    Padding = {
        Top = 12,
        Right = 16,
        Bottom = 24,
        Left = 16,
    },
    Layout = {
        Padding = UDim.new(0.02, 0),
    },
})
```

Scrolling containers use `AutomaticCanvasSize` by default so stacked content can grow without relying on hard-coded canvas sizes.
