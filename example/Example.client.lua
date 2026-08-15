local StarGaze = require(game.ReplicatedStorage.StarGaze)

local UI = StarGaze.create({
	Name = "StarGazeShowcase",
	Theme = "Obsidian",
	DisplayOrder = 100,
	Settings = {
		Style = "Soft",
		Density = "Comfortable",
		Animation = true,
		AnimationSpeed = 0.16,
		Tooltips = true,
		Responsive = true,
	},
})

local window = UI:window({
	Name = "Showcase",
	Title = "StarGaze",
	Subtitle = "UI framework for Roblox",
	Size = UDim2.fromScale(0.82, 0.82),
	Position = UDim2.fromScale(0.5, 0.5),
})

UI:responsive(window.Instance, {
	BaseWidth = 1440,
	Min = 0.76,
	Max = 1.04,
})

local shell = UI:createFrame(window.Content, {
	Name = "Shell",
	Size = UDim2.fromScale(1, 1),
	Color = "Background",
	Radius = 0,
	ClipsDescendants = true,
})

local sidebar = UI:createFrame(shell, {
	Name = "Sidebar",
	Size = UDim2.fromScale(0.19, 1),
	Color = "Surface",
	Radius = 10,
	Stroke = true,
	StrokeColor = "BorderSoft",
	StrokeTransparency = 0.25,
})

local main = UI:createFrame(shell, {
	Name = "Main",
	Size = UDim2.fromScale(0.795, 1),
	Position = UDim2.fromScale(0.205, 0),
	Color = "Background",
	Radius = 0,
	ClipsDescendants = true,
})

local brand = UI:createContainer(sidebar, {
	Size = UDim2.fromScale(0.84, 0.13),
	Position = UDim2.fromScale(0.08, 0.045),
	Color = "Surface",
	Radius = 0,
	Layout = {
		Padding = UDim.new(0, 0),
	},
})

UI:createText(brand, "STARGAZE", {
	Size = UDim2.fromScale(1, 0.44),
	TextSize = 13,
	Font = Enum.Font.GothamBold,
})

UI:createText(brand, "BY STARLIGHT SOLUTIONS", {
	Size = UDim2.fromScale(1, 0.32),
	TextSize = 7,
	Font = Enum.Font.GothamMedium,
	Color = "Muted",
})

UI:divider(brand, {
	Size = UDim2.fromScale(1, 0.01),
})

local nav = UI:createContainer(sidebar, {
	Size = UDim2.fromScale(0.84, 0.52),
	Position = UDim2.fromScale(0.08, 0.2),
	Color = "Surface",
	Radius = 0,
	Layout = {
		Padding = UDim.new(0.018, 0),
	},
})

local pages = {}
local navButtons = {}

local function makePage(name)
	local scroll = UI:scroll(main, {
		Name = name,
		Size = UDim2.fromScale(1, 1),
		Color = "Background",
		Radius = 0,
		Visible = false,
		ScrollBarThickness = 3,
		ScrollBarColor = "Border",
		ScrollBarTransparency = 0.5,
		Padding = {
			Top = 0,
			Right = 18,
			Bottom = 26,
			Left = 18,
		},
		Layout = {
			Padding = UDim.new(0.02, 0),
		},
	})
	pages[name] = scroll
	return scroll
end

local function navButton(name, label, active)
	local button = UI:button(nav, {
		Text = label,
		Color = active and "SurfaceRaised" or "Surface",
		Size = UDim2.fromScale(1, 0.085),
		CornerRadius = 8,
		TextColor = active and "Text" or "Subtext",
		Hover = true,
		Press = true,
	})

	navButtons[name] = button
	return button
end

local function selectPage(name)
	for pageName, page in pairs(pages) do
		page.Visible = pageName == name
	end

	for buttonName, button in pairs(navButtons) do
		local active = buttonName == name
		button:setColor(active and "SurfaceRaised" or "Surface")
		button.Text.TextColor3 = active and UI.Theme.Text or UI.Theme.Subtext
	end
end

local function heading(parent, title, description)
	local block = UI:createContainer(parent, {
		Size = UDim2.fromScale(1, 0.105),
		Color = "Background",
		Radius = 0,
		Layout = {
			Padding = UDim.new(0, 2),
		},
	})

	UI:createText(block, title, {
		Size = UDim2.fromScale(1, 0.58),
		TextSize = 21,
		Font = Enum.Font.GothamBold,
	})

	UI:createText(block, description, {
		Size = UDim2.fromScale(1, 0.34),
		TextSize = 9,
		Color = "Subtext",
		TextWrapped = true,
	})

	return block
end

local overview = makePage("Overview")
local controls = makePage("Controls")
local themes = makePage("Themes")
local components = makePage("Components")
local about = makePage("About")

local overviewButton = navButton("Overview", "Overview", true)
local controlsButton = navButton("Controls", "Controls", false)
local themesButton = navButton("Themes", "Themes", false)
local componentsButton = navButton("Components", "Components", false)
local aboutButton = navButton("About", "About", false)
	overviewButton:connect(function() selectPage("Overview") end)
controlsButton:connect(function() selectPage("Controls") end)
themesButton:connect(function() selectPage("Themes") end)
componentsButton:connect(function() selectPage("Components") end)
aboutButton:connect(function() selectPage("About") end)

UI:createText(sidebar, "MIT LICENSE", {
	Size = UDim2.fromScale(0.84, 0.04),
	Position = UDim2.fromScale(0.08, 0.935),
	TextSize = 7,
	Color = "Muted",
})

heading(overview, "Overview", "A practical showcase of the StarGaze design system.")

local statusRow = UI:createContainer(overview, {
	Size = UDim2.fromScale(1, 0.15),
	Color = "Background",
	Radius = 0,
	Layout = {
		Direction = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0.016, 0),
	},
})

local function metric(parent, label, value, accent)
	local card = UI:card(parent, {
		Size = UDim2.fromScale(0.322, 1),
		Color = "Surface",
		Radius = 10,
		StrokeTransparency = 0.6,
	})

	UI:createText(card, label, {
		Size = UDim2.fromScale(0.82, 0.29),
		Position = UDim2.fromScale(0.08, 0.16),
		TextSize = 8,
		Color = "Muted",
	})

	UI:createText(card, value, {
		Size = UDim2.fromScale(0.82, 0.38),
		Position = UDim2.fromScale(0.08, 0.46),
		TextSize = 17,
		Font = Enum.Font.GothamBold,
		Color = accent or "Text",
	})

	return card
end

metric(statusRow, "RUNTIME", "READY", "Success")
metric(statusRow, "THEMES", "04", "Accent")
metric(statusRow, "COMPONENTS", "20+", "Text")

local previewRow = UI:createContainer(overview, {
	Size = UDim2.fromScale(1, 0.44),
	Color = "Background",
	Radius = 0,
	Layout = {
		Direction = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0.018, 0),
	},
})

local preview = UI:card(previewRow, {
	Size = UDim2.fromScale(0.62, 1),
	Color = "Surface",
	Radius = 11,
	StrokeTransparency = 0.6,
})

local previewInner = UI:createContainer(preview, {
	Size = UDim2.fromScale(0.88, 0.84),
	Position = UDim2.fromScale(0.06, 0.08),
	Color = "Background",
	Radius = 9,
	Padding = {
		Top = 12,
		Right = 14,
		Bottom = 12,
		Left = 14,
	},
	Layout = {
		Padding = UDim.new(0, 7),
	},
})

UI:createText(previewInner, "Live preview", {
	Size = UDim2.fromScale(1, 0.12),
	TextSize = 13,
	Font = Enum.Font.GothamMedium,
})

UI:createText(previewInner, "Components should disappear into the interface. The framework should not.", {
	Size = UDim2.fromScale(1, 0.16),
	TextSize = 9,
	Color = "Subtext",
	TextWrapped = true,
})

UI:toggle(previewInner, {
	Text = "Enable notifications",
	Default = true,
	Size = UDim2.fromScale(1, 0.16),
}):changed(function(value)
	UI:notify({
		Title = "Preview setting",
		Text = value and "Notifications enabled." or "Notifications disabled.",
		Type = "Info",
	})
end)

UI:slider(previewInner, {
	Text = "Interface scale",
	Min = 0.8,
	Max = 1.1,
	Default = 1,
	Size = UDim2.fromScale(1, 0.18),
}):format(function(value)
	return string.format("%.0f%%", value * 100)
end)

UI:button(previewInner, {
	Text = "Test action",
	Size = UDim2.fromScale(1, 0.16),
	OnClick = function()
		UI:notify({
			Title = "Preview",
			Text = "The component event fired correctly.",
			Type = "Success",
		})
	end,
})

local notes = UI:card(previewRow, {
	Size = UDim2.fromScale(0.362, 1),
	Color = "Surface",
	Radius = 11,
	StrokeTransparency = 0.6,
})

local notesInner = UI:createContainer(notes, {
	Size = UDim2.fromScale(0.84, 0.82),
	Position = UDim2.fromScale(0.08, 0.09),
	Color = "Surface",
	Radius = 0,
	Layout = {
		Padding = UDim.new(0, 8),
	},
})

UI:createText(notesInner, "Design notes", {
	Size = UDim2.fromScale(1, 0.13),
	TextSize = 13,
	Font = Enum.Font.GothamMedium,
})

local notesData = {
	{"LAYOUT", "Use scale for composition; reserve offsets for fine detail."},
	{"HIERARCHY", "Keep one clear title, one supporting line, then the controls."},
	{"MOTION", "Animate transitions, not every pixel on the screen."},
}

for _, item in ipairs(notesData) do
	local line = UI:createContainer(notesInner, {
		Size = UDim2.fromScale(1, 0.19),
		Color = "SurfaceAlt",
		Radius = 7,
		Padding = {
			Top = 7,
			Right = 8,
			Bottom = 7,
			Left = 8,
		},
		Layout = {
			Padding = UDim.new(0, 2),
		},
	})

	UI:createText(line, item[1], {
		Size = UDim2.fromScale(1, 0.36),
		TextSize = 7,
		Font = Enum.Font.GothamBold,
		Color = "Muted",
	})

	UI:createText(line, item[2], {
		Size = UDim2.fromScale(1, 0.54),
		TextSize = 8,
		TextWrapped = true,
		Color = "Subtext",
	})
end

local activity = UI:card(overview, {
	Size = UDim2.fromScale(1, 0.25),
	Color = "Surface",
	Radius = 11,
	StrokeTransparency = 0.6,
})

local activityInner = UI:createContainer(activity, {
	Size = UDim2.fromScale(0.94, 0.82),
	Position = UDim2.fromScale(0.03, 0.09),
	Color = "Surface",
	Radius = 0,
	Layout = {
		Padding = UDim.new(0.018, 0),
	},
})

UI:createText(activityInner, "Included in the framework", {
	Size = UDim2.fromScale(1, 0.15),
	TextSize = 13,
	Font = Enum.Font.GothamMedium,
})

local included = UI:createContainer(activityInner, {
	Size = UDim2.fromScale(1, 0.7),
	Color = "Surface",
	Radius = 0,
	Layout = {
		Direction = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0.016, 0),
		Wraps = true,
	},
})

for _, value in ipairs({"Themes", "Styles", "Templates", "Plugins", "Responsive UI", "Notifications", "Command Palette", "20+ controls"}) do
	UI:badge(included, {
		Text = value,
		Color = "SurfaceAlt",
		Size = UDim2.fromScale(0.23, 0.38),
	})
end

heading(controls, "Controls", "The same primitives can be arranged into simple or dense interfaces.")

local controlColumns = UI:createContainer(controls, {
	Size = UDim2.fromScale(1, 0.68),
	Color = "Background",
	Radius = 0,
	Layout = {
		Direction = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0.018, 0),
	},
})

local controlLeft = UI:card(controlColumns, {
	Size = UDim2.fromScale(0.49, 1),
	Color = "Surface",
	Radius = 11,
	StrokeTransparency = 0.6,
})

local leftStack = UI:createContainer(controlLeft, {
	Size = UDim2.fromScale(0.88, 0.9),
	Position = UDim2.fromScale(0.06, 0.05),
	Color = "Surface",
	Radius = 0,
	Layout = {Padding = UDim.new(0.018, 0)},
})

UI:createText(leftStack, "Motion", {Size = UDim2.fromScale(1, 0.1), TextSize = 13, Font = Enum.Font.GothamMedium})
UI:toggle(leftStack, {Text = "Animated interactions", Default = true, Size = UDim2.fromScale(1, 0.11)}):changed(function(value)
	UI:configure({Animation = value})
end)
UI:slider(leftStack, {Text = "Animation speed", Min = 0.05, Max = 0.35, Default = 0.16, Size = UDim2.fromScale(1, 0.14)}):format(function(value)
	return string.format("%.2fs", value)
end):changed(function(value)
	UI:configure({AnimationSpeed = value})
end)
UI:createText(leftStack, "Behavior", {Size = UDim2.fromScale(1, 0.1), TextSize = 13, Font = Enum.Font.GothamMedium})
UI:checkbox(leftStack, {Text = "Show tooltips", Default = true, Size = UDim2.fromScale(1, 0.11)})
UI:checkbox(leftStack, {Text = "Use responsive scaling", Default = true, Size = UDim2.fromScale(1, 0.11)})

local controlRight = UI:card(controlColumns, {
	Size = UDim2.fromScale(0.492, 1),
	Color = "Surface",
	Radius = 11,
	StrokeTransparency = 0.6,
})

local rightStack = UI:createContainer(controlRight, {
	Size = UDim2.fromScale(0.88, 0.9),
	Position = UDim2.fromScale(0.06, 0.05),
	Color = "Surface",
	Radius = 0,
	Layout = {Padding = UDim.new(0.018, 0)},
})

UI:createText(rightStack, "Appearance", {Size = UDim2.fromScale(1, 0.1), TextSize = 13, Font = Enum.Font.GothamMedium})
UI:dropdown(rightStack, {Text = "Density", Items = {"Compact", "Comfortable", "Spacious"}, Default = "Comfortable", Size = UDim2.fromScale(1, 0.12)}):changed(function(value)
	UI:configure({Density = value})
end)
UI:segmented(rightStack, {Items = {"Soft", "Sharp", "Glass"}, Default = "Soft", Size = UDim2.fromScale(1, 0.12)}):changed(function(value)
	UI:configure({Style = value})
end)
UI:createText(rightStack, "Feedback", {Size = UDim2.fromScale(1, 0.1), TextSize = 13, Font = Enum.Font.GothamMedium})
UI:progress(rightStack, {Text = "Framework coverage", Default = 0.88, Size = UDim2.fromScale(1, 0.12)})
UI:button(rightStack, {Text = "Show confirmation", Color = "SurfaceAlt", Size = UDim2.fromScale(1, 0.11), OnClick = function()
	UI:confirm({
		Title = "Example confirmation",
		Text = "This dialog is part of the same component system.",
		OnConfirm = function()
			UI:notify({Title = "Confirmed", Text = "The action was accepted.", Type = "Success"})
		end,
	})
end})

heading(themes, "Themes", "Four dark palettes are included, and custom themes can be registered at runtime.")

local themeList = UI:createContainer(themes, {
	Size = UDim2.fromScale(1, 0.52),
	Color = "Background",
	Radius = 0,
	Layout = {Padding = UDim.new(0.018, 0)},
})

for _, name in ipairs({"Obsidian", "Midnight", "Carbon", "Violet"}) do
	local row = UI:createFrame(themeList, {
		Size = UDim2.fromScale(1, 0.19),
		Color = "Surface",
		Radius = 9,
		Stroke = true,
		StrokeColor = "BorderSoft",
		StrokeTransparency = 0.45,
	})

	UI:createText(row, name, {Size = UDim2.fromScale(0.5, 1), Position = UDim2.fromScale(0.04, 0), TextSize = 11, Font = Enum.Font.GothamMedium})
	UI:createText(row, "Built-in palette", {Size = UDim2.fromScale(0.22, 1), Position = UDim2.fromScale(0.54, 0), TextSize = 8, Color = "Muted", TextXAlignment = Enum.TextXAlignment.Right})

	UI:button(row, {
		Text = "Use",
		Color = name == "Obsidian" and "Accent" or "SurfaceAlt",
		Size = UDim2.fromScale(0.14, 0.62),
		Position = UDim2.fromScale(0.81, 0.19),
		OnClick = function()
			UI:setTheme(name)
			UI:notify({Title = "Theme changed", Text = name .. " is now active.", Type = "Info"})
		end,
	})
end

local stylePreview = UI:card(themes, {Size = UDim2.fromScale(1, 0.26), Color = "Surface", Radius = 11, StrokeTransparency = 0.6})
UI:createText(stylePreview, "Style presets", {Size = UDim2.fromScale(0.9, 0.18), Position = UDim2.fromScale(0.04, 0.08), TextSize = 13, Font = Enum.Font.GothamMedium})
UI:createText(stylePreview, "Soft, Sharp, Glass and Dense styles can be registered or replaced for a project.", {Size = UDim2.fromScale(0.9, 0.28), Position = UDim2.fromScale(0.04, 0.31), TextSize = 9, Color = "Subtext", TextWrapped = true})
UI:segmented(stylePreview, {Items = {"Soft", "Sharp", "Glass", "Dense"}, Default = "Soft", Size = UDim2.fromScale(0.92, 0.24), Position = UDim2.fromScale(0.04, 0.66)}):changed(function(value)
	UI:configure({Style = value})
end)

heading(components, "Components", "A compact inventory of the controls exposed by the framework.")

local componentList = UI:createContainer(components, {
	Size = UDim2.fromScale(1, 0.78),
	Color = "Background",
	Radius = 0,
	Layout = {
		Padding = UDim.new(0.012, 0),
	},
})

for _, name in ipairs({
	"Window", "Button", "Toggle", "Checkbox", "Radio", "Slider", "Progress", "Input",
	"Dropdown", "Tabs", "Segmented", "Accordion", "Keybind", "ColorPicker", "Notification",
	"Confirm", "ContextMenu", "CommandPalette", "Tooltip", "Badge",
}) do
	local row = UI:createFrame(componentList, {
		Size = UDim2.fromScale(1, 0.075),
		Color = "Surface",
		Radius = 8,
	})
	UI:createText(row, name, {Size = UDim2.fromScale(0.65, 1), Position = UDim2.fromScale(0.04, 0), TextSize = 9, Font = Enum.Font.GothamMedium})
	UI:createText(row, "Component", {Size = UDim2.fromScale(0.25, 1), Position = UDim2.fromScale(0.71, 0), TextSize = 8, Color = "Muted", TextXAlignment = Enum.TextXAlignment.Right})
end

heading(about, "About", "StarGaze is designed to be a framework you build with, not a demo you copy.")

local aboutCard = UI:card(about, {
	Size = UDim2.fromScale(1, 0.48),
	Color = "Surface",
	Radius = 11,
	StrokeTransparency = 0.6,
})

local aboutInner = UI:createContainer(aboutCard, {
	Size = UDim2.fromScale(0.88, 0.82),
	Position = UDim2.fromScale(0.06, 0.09),
	Color = "Surface",
	Radius = 0,
	Layout = {Padding = UDim.new(0.02, 0)},
})

UI:createText(aboutInner, "A small runtime, reusable components, and a design system.", {
	Size = UDim2.fromScale(1, 0.14),
	TextSize = 15,
	Font = Enum.Font.GothamMedium,
	TextWrapped = true,
})

UI:createText(aboutInner, "StarGaze keeps the public API straightforward while leaving room for custom themes, styles, templates and plugins. The example intentionally uses restrained spacing and scale-based composition so the framework is shown in a realistic setting.", {
	Size = UDim2.fromScale(1, 0.3),
	TextSize = 9,
	Color = "Subtext",
	TextWrapped = true,
	TextYAlignment = Enum.TextYAlignment.Top,
})

UI:divider(aboutInner)
UI:createText(aboutInner, "Built by Starlight Solutions, Inc.", {Size = UDim2.fromScale(1, 0.1), TextSize = 10, Font = Enum.Font.GothamMedium})
UI:createText(aboutInner, "Luau · Roblox · MIT License", {Size = UDim2.fromScale(1, 0.1), TextSize = 8, Color = "Muted"})

local palette = UI:commandPalette({
	Placeholder = "Search StarGaze",
	Items = {
		{Name = "Overview", OnClick = function() selectPage("Overview") end},
		{Name = "Controls", OnClick = function() selectPage("Controls") end},
		{Name = "Themes", OnClick = function() selectPage("Themes") end},
		{Name = "Components", OnClick = function() selectPage("Components") end},
		{Name = "About", OnClick = function() selectPage("About") end},
		{Name = "Obsidian", OnClick = function() UI:setTheme("Obsidian") end},
		{Name = "Midnight", OnClick = function() UI:setTheme("Midnight") end},
		{Name = "Carbon", OnClick = function() UI:setTheme("Carbon") end},
		{Name = "Violet", OnClick = function() UI:setTheme("Violet") end},
	},
})

UI:tooltip(themesButton.Instance, {
	Text = "Switch palettes and styles.",
})

UI:tooltip(componentsButton.Instance, {
	Text = "Browse the available controls.",
})

selectPage("Overview")
window:open()

UI:notify({
	Title = "StarGaze",
	Text = "Showcase loaded.",
	Type = "Success",
	Duration = 3,
})
