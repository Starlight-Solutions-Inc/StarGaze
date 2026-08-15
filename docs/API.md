# StarGaze API

## Runtime

```lua
local UI = StarGaze.create(options)
```

### Creation

- `UI:window(options)`
- `UI:createFrame(parent, options)`
- `UI:createText(parent, text, options)`
- `UI:createContainer(parent, options)`
- `UI:card(parent, options)`
- `UI:glass(parent, options)`

### Components

- `UI:button(parent, options)`
- `UI:toggle(parent, options)`
- `UI:checkbox(parent, options)`
- `UI:radio(parent, options)`
- `UI:slider(parent, options)`
- `UI:progress(parent, options)`
- `UI:dropdown(parent, options)`
- `UI:input(parent, options)`
- `UI:tabs(parent, options)`
- `UI:segmented(parent, options)`
- `UI:accordion(parent, options)`
- `UI:keybind(parent, options)`
- `UI:colorPicker(parent, options)`
- `UI:badge(parent, options)`
- `UI:divider(parent, options)`
- `UI:tooltip(target, options)`
- `UI:notification(options)`
- `UI:notify(options)`
- `UI:confirm(options)`
- `UI:contextMenu(options)`
- `UI:commandPalette(options)`

### Runtime utilities

- `UI:setTheme(theme)`
- `UI:onThemeChanged(callback)`
- `UI:responsive(root, options)`
- `UI:animate(instance, properties, duration, style, direction)`
- `UI:destroy()`

## Component conventions

Most interactive components return a handle instead of exposing raw Roblox instances as the primary API.

Common methods include:

```lua
component:set(value)
component:get()
component:changed(callback)
component:destroy()
```

Specialized components expose additional methods such as `open`, `close`, `toggle`, `select`, `connect`, and `setText`.
