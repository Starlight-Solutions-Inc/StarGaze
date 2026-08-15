local StarGaze = require(game.ReplicatedStorage.StarGaze)

local UI = StarGaze.create({
	Name = "StarGazeShowcase",
	Theme = "Obsidian",
	DisplayOrder = 100,
	Settings = {
		Style = "Soft",
		Density = "Comfortable",
		AnimationSpeed = 0.16,
		Tooltips = true,
		Responsive = true,
	},
})

local window = UI:window({
	Name = "Showcase",
	Title = "StarGaze",
	Subtitle = "A practical Roblox UI framework",
	Size = UDim2.fromScale(0.78, 0.8),
	Position = UDim2.fromScale(0.5, 0.5),
})

UI:responsive(window.Instance, {
	BaseWidth = 1440,
	Min = 0.78,
	Max = 1.04,
})

local content = window.Content
content.BackgroundColor3 = UI.Theme.Background

local sidebar = UI:createFrame(content, {
	Name = "Sidebar",
	Size = UDim2.fromScale(0.19, 1),
	Color = "Surface",
	Radius = 12,
	Stroke = true,
	StrokeColor = "Border",
	StrokeTransparency = 0.55,
})

local main = UI:createFrame(content, {
	Name = "Main",
	Size = UDim2.fromScale(0.775, 1),
	Position = UDim2.fromScale(0.22, 0),
	Color = "Background",
	Radius = 0,
	ClipsDescendants = true,
})

UI:createText(sidebar, "STARGAZE", {
	Size = UDim2.fromScale(0.84, 0.06),
	Position = UDim2.fromScale(0.08, 0.055),
	TextSize = 13,
	Font = Enum.Font.GothamBold,
})

UI:createText(sidebar, "FRAMEWORK", {
	Size = UDim2.fromScale(0.84, 0.035),
	Position = UDim2.fromScale(0.08, 0.112),
	TextSize = 8,
	Font = Enum.Font.GothamMedium,
	Color = "Subtext",
})

local pages = {}
local navItems = {}

local function page(name)
	local result = UI:createFrame(main, {
		Name = name,
		Size = UDim2.fromScale(1, 1),
		Color = "Background",
		Radius = 0,
		Visible = false,
		ClipsDescendants = true,
	})
	pages[name] = result
	return result
end

local function selectPage(name)
	for pageName, current in pairs(pages) do
		current.Visible = pageName == name
	end

	for itemName, item in pairs(navItems) do
		local active = itemName == name
		UI:animate(item, {
			BackgroundColor3 = active and UI.Theme.SurfaceAlt or UI.Theme.Surface,
			BackgroundTransparency = active and 0 or 1,
		}, 0.12)
		item.Marker.Visible = active
	end
end

local function navigation(name, title, y)
	local holder = UI:createFrame(sidebar, {
		Name = name .. "Navigation",
		Size = UDim2.fromScale(0.84, 0.065),
		Position = UDim2.fromScale(0.08, y),
		Color = "Surface",
		Radius = 8,
	})

	local button = Instance.new("TextButton")
	button.BackgroundTransparency = 1
	button.BorderSizePixel = 0
	button.Size = UDim2.fromScale(1, 1)
	button.Text = ""
	button.AutoButtonColor = false
	button.Parent = holder

	local marker = UI:createFrame(holder, {
		Name = "Marker",
		Size = UDim2.fromScale(0.018, 0.44),
		Position = UDim2.fromScale(0.03, 0.28),
		Color = "Accent",
		Radius = 99,
		Visible = false,
	})

	UI:createText(holder, title, {
		Size = UDim2.fromScale(0.78, 1),
		Position = UDim2.fromScale(0.12, 0),
		TextSize = 11,
		Color = "Subtext",
	})

	UI:connect(button.Activated:Connect(function()
		selectPage(name)
	end))

	navItems[name] = {
		Holder = holder,
		Button = button,
		Marker = marker,
	}
end

navigation("Overview", "Overview", 0.18)
navigation("Controls", "Controls", 0.255)
navigation("Themes", "Themes", 0.33)
navigation("Components", "Components", 0.405)
navigation("About", "About", 0.48)

UI:createText(sidebar, "Starlight Solutions, Inc.", {
	Size = UDim2.fromScale(0.84, 0.045),
	Position = UDim2.fromScale(0.08, 0.92),
	TextSize = 8,
	Color = "Subtext",
})

local overview = page("Overview")

UI:createText(overview, "Overview", {
	Size = UDim2.fromScale(0.9, 0.07),
	Position = UDim2.fromScale(0.03, 0.025),
	TextSize = 21,
	Font = Enum.Font.GothamBold,
})

UI:createText(overview, "A restrained example of how StarGaze can be composed into a real interface.", {
	Size = UDim2.fromScale(0.9, 0.045),
	Position = UDim2.fromScale(0.03, 0.092),
	TextSize = 10,
	Color = "Subtext",
})

local status = UI:card(overview, {
	Size = UDim2.fromScale(0.94, 0.14),
	Position = UDim2.fromScale(0.03, 0.16),
	Color = "Surface",
	Radius = 11,
	StrokeTransparency = 0.55,
})

UI:createText(status, "READY", {
	Size = UDim2.fromScale(0.13, 0.26),
	Position = UDim2.fromScale(0.04, 0.17),
	TextSize = 9,
	Font = Enum.Font.GothamBold,
	Color = "Success",
})

UI:createText(status, "StarGaze runtime initialized", {
	Size = UDim2.fromScale(0.62, 0.34),
	Position = UDim2.fromScale(0.04, 0.48),
	TextSize = 13,
	Font = Enum.Font.GothamMedium,
})

UI:createText(status, "Themes, components, templates and plugins are available.", {
	Size = UDim2.fromScale(0.62, 0.24),
	Position = UDim2.fromScale(0.34, 0.51),
	TextSize = 9,
	Color = "Subtext",
})

UI:badge(status, {
	Text = "v2.1",
	Color = "Accent",
	Size = UDim2.fromScale(0.13, 0.34),
	Position = UDim2.fromScale(0.82, 0.33),
})

local left = UI:card(overview, {
	Size = UDim2.fromScale(0.58, 0.55),
	Position = UDim2.fromScale(0.03, 0.34),
	Color = "Surface",
	Radius = 12,
})

UI:createText(left, "Live preview", {
	Size = UDim2.fromScale(0.88, 0.08),
	Position = UDim2.fromScale(0.06, 0.06),
	TextSize = 13,
	Font = Enum.Font.GothamMedium,
})

local preview = UI:card(left, {
	Size = UDim2.fromScale(0.88, 0.72),
	Position = UDim2.fromScale(0.06, 0.18),
	Color = "Background",
	Radius = 10,
	StrokeTransparency = 0.65,
})

UI:createText(preview, "Account settings", {
	Size = UDim2.fromScale(0.84, 0.1),
	Position = UDim2.fromScale(0.07, 0.08),
	TextSize = 13,
	Font = Enum.Font.GothamMedium,
})

UI:createText(preview, "Small, focused controls work better than filling every corner with cards.", {
	Size = UDim2.fromScale(0.84, 0.18),
	Position = UDim2.fromScale(0.07, 0.22),
	TextSize = 9,
	TextWrapped = true,
	TextYAlignment = Enum.TextYAlignment.Top,
	Color = "Subtext",
})

local previewToggle = UI:toggle(preview, {
	Text = "Enable notifications",
	Default = true,
	Size = UDim2.fromScale(0.84, 0.14),
	Position = UDim2.fromScale(0.07, 0.45),
})

previewToggle:changed(function(value)
	UI:notify({
		Title = "Preview setting",
		Text = value and "Notifications enabled." or "Notifications disabled.",
		Type = "Info",
	})
end)

UI:button(preview, {
	Text = "Test action",
	Size = UDim2.fromScale(0.38, 0.13),
	Position = UDim2.fromScale(0.07, 0.72),
	OnClick = function()
		UI:notify({
			Title = "Action completed",
			Text = "The preview button fired normally.",
			Type = "Success",
		})
	end,
})

local right = UI:card(overview, {
	Size = UDim2.fromScale(0.33, 0.55),
	Position = UDim2.fromScale(0.64, 0.34),
	Color = "Surface",
	Radius = 12,
})

UI:createText(right, "Configuration", {
	Size = UDim2.fromScale(0.84, 0.08),
	Position = UDim2.fromScale(0.08, 0.06),
	TextSize = 13,
	Font = Enum.Font.GothamMedium,
})

UI:createText(right, "Theme", {
	Size = UDim2.fromScale(0.36, 0.06),
	Position = UDim2.fromScale(0.08, 0.19),
	TextSize = 9,
	Color = "Subtext",
})

UI:createText(right, "Obsidian", {
	Size = UDim2.fromScale(0.44, 0.06),
	Position = UDim2.fromScale(0.48, 0.19),
	TextSize = 10,
	TextXAlignment = Enum.TextXAlignment.Right,
})

UI:createText(right, "Density", {
	Size = UDim2.fromScale(0.36, 0.06),
	Position = UDim2.fromScale(0.08, 0.31),
	TextSize = 9,
	Color = "Subtext",
})

UI:createText(right, "Comfortable", {
	Size = UDim2.fromScale(0.44, 0.06),
	Position = UDim2.fromScale(0.48, 0.31),
	TextSize = 10,
	TextXAlignment = Enum.TextXAlignment.Right,
})

UI:progress(right, {
	Text = "System coverage",
	Default = 0.88,
	Size = UDim2.fromScale(0.84, 0.12),
	Position = UDim2.fromScale(0.08, 0.46),
})

UI:button(right, {
	Text = "Open command palette",
	Color = "SurfaceAlt",
	Size = UDim2.fromScale(0.84, 0.12),
	Position = UDim2.fromScale(0.08, 0.64),
	OnClick = function()
		palette:open()
	end,
})

local controls = page("Controls")
UI:createText(controls, "Controls", {
	Size = UDim2.fromScale(0.9, 0.07),
	Position = UDim2.fromScale(0.03, 0.025),
	TextSize = 21,
	Font = Enum.Font.GothamBold,
})
UI:createText(controls, "Use the same component APIs in your own layouts.", {
	Size = UDim2.fromScale(0.9, 0.045),
	Position = UDim2.fromScale(0.03, 0.092),
	TextSize = 10,
	Color = "Subtext",
})

local controlPanel = UI:card(controls, {
	Size = UDim2.fromScale(0.94, 0.7),
	Position = UDim2.fromScale(0.03, 0.17),
	Color = "Surface",
	Radius = 12,
})

UI:toggle(controlPanel, {
	Text = "Animated interactions",
	Default = true,
	Size = UDim2.fromScale(0.92, 0.11),
	Position = UDim2.fromScale(0.04, 0.08),
}):changed(function(value)
	UI:configure({Animation = value})
end)

UI:checkbox(controlPanel, {
	Text = "Show tooltips",
	Default = true,
	Size = UDim2.fromScale(0.92, 0.11),
	Position = UDim2.fromScale(0.04, 0.22),
})

UI:slider(controlPanel, {
	Text = "Animation speed",
	Min = 0.05,
	Max = 0.4,
	Default = 0.16,
	Size = UDim2.fromScale(0.92, 0.12),
	Position = UDim2.fromScale(0.04, 0.37),
}):format(function(value)
	return string.format("%.2fs", value)
end):changed(function(value)
	UI:configure({AnimationSpeed = value})
end)

UI:dropdown(controlPanel, {
	Text = "Density",
	Items = {"Comfortable", "Compact", "Spacious"},
	Default = "Comfortable",
	Size = UDim2.fromScale(0.92, 0.12),
	Position = UDim2.fromScale(0.04, 0.52),
}):changed(function(value)
	UI:configure({Density = value})
end)

local themes = page("Themes")
UI:createText(themes, "Themes", {
	Size = UDim2.fromScale(0.9, 0.07),
	Position = UDim2.fromScale(0.03, 0.025),
	TextSize = 21,
	Font = Enum.Font.GothamBold,
})
UI:createText(themes, "Switch between built-in palettes or register your own theme in code.", {
	Size = UDim2.fromScale(0.9, 0.045),
	Position = UDim2.fromScale(0.03, 0.092),
	TextSize = 10,
	Color = "Subtext",
})

local themePanel = UI:card(themes, {
	Size = UDim2.fromScale(0.94, 0.64),
	Position = UDim2.fromScale(0.03, 0.17),
	Color = "Surface",
	Radius = 12,
})

local themeNames = {"Obsidian", "Midnight", "Carbon", "Violet"}
for index, name in ipairs(themeNames) do
	UI:button(themePanel, {
		Text = name,
		Color = name == "Obsidian" and "Accent" or "SurfaceAlt",
		Size = UDim2.fromScale(0.42, 0.12),
		Position = UDim2.fromScale(0.05 + ((index - 1) % 2) * 0.47, 0.08 + math.floor((index - 1) / 2) * 0.17),
		OnClick = function()
			UI:setTheme(name)
			UI:notify({
				Title = "Theme changed",
				Text = name .. " is now active.",
				Type = "Info",
			})
		end,
	})
end

local components = page("Components")
UI:createText(components, "Components", {
	Size = UDim2.fromScale(0.9, 0.07),
	Position = UDim2.fromScale(0.03, 0.025),
	TextSize = 21,
	Font = Enum.Font.GothamBold,
})
UI:createText(components, "StarGaze keeps common controls consistent across a project.", {
	Size = UDim2.fromScale(0.9, 0.045),
	Position = UDim2.fromScale(0.03, 0.092),
	TextSize = 10,
	Color = "Subtext",
})

local componentPanel = UI:card(components, {
	Size = UDim2.fromScale(0.94, 0.7),
	Position = UDim2.fromScale(0.03, 0.17),
	Color = "Surface",
	Radius = 12,
})

local componentNames = {
	"Window", "Button", "Toggle", "Checkbox", "Radio", "Slider",
	"Progress", "Input", "Dropdown", "Tabs", "Segmented", "Accordion",
	"Keybind", "ColorPicker", "Notification", "CommandPalette",
}

for index, name in ipairs(componentNames) do
	local row = math.floor((index - 1) / 2)
	local column = (index - 1) % 2
	local item = UI:createFrame(componentPanel, {
		Size = UDim2.fromScale(0.42, 0.085),
		Position = UDim2.fromScale(0.05 + column * 0.47, 0.05 + row * 0.105),
		Color = "SurfaceAlt",
		Radius = 8,
	})
	UI:createText(item, name, {
		Size = UDim2.fromScale(0.84, 1),
		Position = UDim2.fromScale(0.08, 0),
		TextSize = 9,
	})
end

local about = page("About")
UI:createText(about, "About StarGaze", {
	Size = UDim2.fromScale(0.9, 0.07),
	Position = UDim2.fromScale(0.03, 0.025),
	TextSize = 21,
	Font = Enum.Font.GothamBold,
})

local aboutCard = UI:card(about, {
	Size = UDim2.fromScale(0.94, 0.58),
	Position = UDim2.fromScale(0.03, 0.16),
	Color = "Surface",
	Radius = 12,
})

UI:createText(aboutCard, "A UI framework, not a widget dump.", {
	Size = UDim2.fromScale(0.84, 0.12),
	Position = UDim2.fromScale(0.08, 0.1),
	TextSize = 16,
	Font = Enum.Font.GothamMedium,
})

UI:createText(aboutCard, "StarGaze is built around a small runtime, reusable components, a theme system, styles, templates and plugins. The goal is to make interfaces feel intentionally designed while keeping the implementation approachable.", {
	Size = UDim2.fromScale(0.84, 0.28),
	Position = UDim2.fromScale(0.08, 0.27),
	TextSize = 10,
	TextWrapped = true,
	TextYAlignment = Enum.TextYAlignment.Top,
	Color = "Subtext",
})

UI:createText(aboutCard, "Built by Starlight Solutions, Inc.", {
	Size = UDim2.fromScale(0.84, 0.08),
	Position = UDim2.fromScale(0.08, 0.65),
	TextSize = 11,
})

UI:createText(aboutCard, "MIT License · Luau · Roblox", {
	Size = UDim2.fromScale(0.84, 0.07),
	Position = UDim2.fromScale(0.08, 0.76),
	TextSize = 9,
	Color = "Subtext",
})

local palette
palette = UI:commandPalette({
	Placeholder = "Search StarGaze...",
	Items = {
		{Name = "Overview", OnClick = function() selectPage("Overview") end},
		{Name = "Controls", OnClick = function() selectPage("Controls") end},
		{Name = "Themes", OnClick = function() selectPage("Themes") end},
		{Name = "Components", OnClick = function() selectPage("Components") end},
		{Name = "About", OnClick = function() selectPage("About") end},
		{Name = "Obsidian Theme", OnClick = function() UI:setTheme("Obsidian") end},
		{Name = "Midnight Theme", OnClick = function() UI:setTheme("Midnight") end},
		{Name = "Carbon Theme", OnClick = function() UI:setTheme("Carbon") end},
		{Name = "Violet Theme", OnClick = function() UI:setTheme("Violet") end},
	},
})

UI:tooltip(navItems.Themes.Button, {
	Text = "Switch themes and define custom palettes.",
})

selectPage("Overview")
window:open()

UI:notify({
	Title = "StarGaze",
	Text = "Showcase loaded.",
	Type = "Success",
})
