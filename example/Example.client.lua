local StarGaze = require(game.ReplicatedStorage.StarGaze)

local UI = StarGaze.create({
	Name = "StarGazeExample",
	Theme = "Obsidian",
	DisplayOrder = 100,
})

local window = UI:window({
	Name = "Studio",
	Title = "StarGaze",
	Subtitle = "Interface framework for Roblox",
	Size = UDim2.fromScale(0.78, 0.78),
	Position = UDim2.fromScale(0.5, 0.5),
})

local content = window.Content
content.BackgroundColor3 = UI.Theme.Background

local sidebar = UI:createFrame(content, {
	Name = "Sidebar",
	Size = UDim2.fromScale(0.2, 1),
	Position = UDim2.fromScale(0, 0),
	Color = "Surface",
	Radius = 12,
	Stroke = true,
	StrokeColor = "BorderSoft",
	StrokeTransparency = 0.2,
})

local brand = UI:createText(sidebar, "STARGAZE", {
	Size = UDim2.fromScale(0.84, 0.07),
	Position = UDim2.fromScale(0.08, 0.055),
	TextSize = 13,
	Font = Enum.Font.GothamBold,
})

local brandLine = UI:createFrame(sidebar, {
	Size = UDim2.fromScale(0.84, 0.003),
	Position = UDim2.fromScale(0.08, 0.135),
	Color = "BorderSoft",
	Radius = 1,
})

local section = UI:createText(sidebar, "WORKSPACE", {
	Size = UDim2.fromScale(0.84, 0.04),
	Position = UDim2.fromScale(0.08, 0.17),
	TextSize = 9,
	Font = Enum.Font.GothamMedium,
	Color = "Muted",
})

local pages = {}
local navButtons = {}

local function makePage(name)
	local page = UI:createFrame(content, {
		Name = name,
		Size = UDim2.fromScale(0.755, 0.93),
		Position = UDim2.fromScale(0.23, 0.04),
		Color = "Background",
		Radius = 0,
		Visible = false,
		ClipsDescendants = true,
	})
	pages[name] = page
	return page
end

local function selectPage(name)
	for pageName, page in pairs(pages) do
		page.Visible = pageName == name
	end

	for buttonName, button in pairs(navButtons) do
		local active = buttonName == name
		UI:animate(button, {
			BackgroundColor3 = active and UI.Theme.SurfaceRaised or UI.Theme.Surface,
			BackgroundTransparency = active and 0 or 1,
		}, 0.12)
	end
end

local function nav(name, labelText, y)
	local button = UI:createFrame(sidebar, {
		Name = name .. "Nav",
		Size = UDim2.fromScale(0.84, 0.065),
		Position = UDim2.fromScale(0.08, y),
		Color = "Surface",
		Radius = 8,
		Stroke = true,
		StrokeColor = "BorderSoft",
		StrokeTransparency = 1,
	})

	local click = Instance.new("TextButton")
	click.BackgroundTransparency = 1
	click.Size = UDim2.fromScale(1, 1)
	click.Text = ""
	click.AutoButtonColor = false
	click.Parent = button

	local marker = UI:createFrame(button, {
		Size = UDim2.fromScale(0.018, 0.46),
		Position = UDim2.fromScale(0.03, 0.27),
		Color = "Accent",
		Radius = 99,
		Visible = false,
	})

	UI:createText(button, labelText, {
		Size = UDim2.fromScale(0.78, 1),
		Position = UDim2.fromScale(0.12, 0),
		TextSize = 12,
		Color = "Subtext",
	})

	UI:connect(click.Activated:Connect(function()
		selectPage(name)
		for navName, navButton in pairs(navButtons) do
			local indicator = navButton:FindFirstChild("Indicator")
			if indicator then
				indicator.Visible = navName == name
			end
		end
	end))

	marker.Name = "Indicator"
	navButtons[name] = button
	return button
end

nav("Overview", "Overview", 0.235)
nav("Controls", "Controls", 0.31)
nav("Themes", "Themes", 0.385)
nav("About", "About", 0.46)

local footer = UI:createText(sidebar, "Starlight Solutions, Inc.", {
	Size = UDim2.fromScale(0.84, 0.05),
	Position = UDim2.fromScale(0.08, 0.91),
	TextSize = 9,
	Color = "Muted",
})

local overview = makePage("Overview")

UI:createText(overview, "Overview", {
	Size = UDim2.fromScale(0.9, 0.07),
	Position = UDim2.fromScale(0.03, 0.01),
	TextSize = 22,
	Font = Enum.Font.GothamBold,
})

UI:createText(overview, "A working reference interface built with StarGaze components.", {
	Size = UDim2.fromScale(0.9, 0.05),
	Position = UDim2.fromScale(0.03, 0.075),
	TextSize = 11,
	Color = "Subtext",
})

local stats = UI:createFrame(overview, {
	Size = UDim2.fromScale(0.94, 0.19),
	Position = UDim2.fromScale(0.03, 0.15),
	Color = "Background",
	Radius = 0,
})

local function stat(title, value, x, accent)
	local card = UI:card(stats, {
		Size = UDim2.fromScale(0.31, 1),
		Position = UDim2.fromScale(x, 0),
		Color = "Surface",
		Radius = 10,
		StrokeTransparency = 0.55,
	})

	UI:createText(card, title, {
		Size = UDim2.fromScale(0.84, 0.28),
		Position = UDim2.fromScale(0.08, 0.15),
		TextSize = 10,
		Color = "Muted",
	})

	UI:createText(card, value, {
		Size = UDim2.fromScale(0.84, 0.42),
		Position = UDim2.fromScale(0.08, 0.41),
		TextSize = 20,
		Font = Enum.Font.GothamBold,
		Color = accent or "Text",
	})
end

stat("COMPONENTS", "24", 0)
stat("THEMES", "4", 0.345)
stat("VERSION", "2.0", 0.69, "Accent")

local preview = UI:glass(overview, {
	Size = UDim2.fromScale(0.61, 0.52),
	Position = UDim2.fromScale(0.03, 0.38),
	Color = "Glass",
	Transparency = 0.08,
	Radius = 12,
})

UI:createText(preview, "Live preview", {
	Size = UDim2.fromScale(0.88, 0.09),
	Position = UDim2.fromScale(0.06, 0.07),
	TextSize = 13,
	Font = Enum.Font.GothamMedium,
})

local previewBody = UI:card(preview, {
	Size = UDim2.fromScale(0.88, 0.72),
	Position = UDim2.fromScale(0.06, 0.19),
	Color = "Surface",
	Radius = 9,
})

UI:createText(previewBody, "Example panel", {
	Size = UDim2.fromScale(0.86, 0.12),
	Position = UDim2.fromScale(0.07, 0.08),
	TextSize = 14,
	Font = Enum.Font.GothamMedium,
})

UI:createText(previewBody, "Components are intended to feel like parts of one system, not a collection of unrelated widgets.", {
	Size = UDim2.fromScale(0.86, 0.24),
	Position = UDim2.fromScale(0.07, 0.22),
	TextSize = 10,
	Color = "Subtext",
	TextWrapped = true,
	TextYAlignment = Enum.TextYAlignment.Top,
})

UI:progress(previewBody, {
	Text = "Build progress",
	Default = 0.84,
	Size = UDim2.fromScale(0.86, 0.12),
	Position = UDim2.fromScale(0.07, 0.52),
})

local previewButton = UI:button(previewBody, {
	Text = "Test interaction",
	Size = UDim2.fromScale(0.42, 0.14),
	Position = UDim2.fromScale(0.07, 0.72),
	Radius = 8,
	OnClick = function()
		UI:notify({
			Title = "Interaction",
			Text = "Button event received.",
			Type = "Success",
		})
	end,
})

local activity = UI:card(overview, {
	Size = UDim2.fromScale(0.31, 0.52),
	Position = UDim2.fromScale(0.66, 0.38),
	Color = "Surface",
	Radius = 12,
})

UI:createText(activity, "Recent activity", {
	Size = UDim2.fromScale(0.84, 0.1),
	Position = UDim2.fromScale(0.08, 0.07),
	TextSize = 13,
	Font = Enum.Font.GothamMedium,
})

local activities = {
	{"Theme loaded", "Obsidian", "Success"},
	{"Input ready", "TextBox", "Info"},
	{"Interaction test", "Waiting", "Subtext"},
}

for i, item in ipairs(activities) do
	local row = UI:createFrame(activity, {
		Size = UDim2.fromScale(0.84, 0.18),
		Position = UDim2.fromScale(0.08, 0.2 + (i - 1) * 0.2),
		Color = "SurfaceAlt",
		Radius = 8,
	})

	local dot = UI:createFrame(row, {
		Size = UDim2.fromScale(0.04, 0.18),
		Position = UDim2.fromScale(0.05, 0.41),
		Color = item[3],
		Radius = 99,
	})

	UI:createText(row, item[1], {
		Size = UDim2.fromScale(0.78, 0.45),
		Position = UDim2.fromScale(0.13, 0.14),
		TextSize = 10,
	})

	UI:createText(row, item[2], {
		Size = UDim2.fromScale(0.78, 0.3),
		Position = UDim2.fromScale(0.13, 0.54),
		TextSize = 9,
		Color = "Muted",
	})
end

local controls = makePage("Controls")
UI:createText(controls, "Controls", {
	Size = UDim2.fromScale(0.9, 0.07),
	Position = UDim2.fromScale(0.03, 0.01),
	TextSize = 22,
	Font = Enum.Font.GothamBold,
})

UI:createText(controls, "Tune common interface behavior without leaving the framework.", {
	Size = UDim2.fromScale(0.9, 0.05),
	Position = UDim2.fromScale(0.03, 0.075),
	TextSize = 11,
	Color = "Subtext",
})

UI:toggle(controls, {
	Text = "Animated transitions",
	Size = UDim2.fromScale(0.94, 0.115),
	Position = UDim2.fromScale(0.03, 0.16),
	Default = true,
})

UI:checkbox(controls, {
	Text = "Compact controls",
	Size = UDim2.fromScale(0.94, 0.115),
	Position = UDim2.fromScale(0.03, 0.295),
	Default = false,
})

UI:slider(controls, {
	Text = "Animation intensity",
	Size = UDim2.fromScale(0.94, 0.13),
	Position = UDim2.fromScale(0.03, 0.43),
	Min = 0,
	Max = 100,
	Default = 70,
})

UI:segmented(controls, {
	Size = UDim2.fromScale(0.94, 0.115),
	Position = UDim2.fromScale(0.03, 0.58),
	Items = {
		{Name = "Low", Text = "Low"},
		{Name = "Balanced", Text = "Balanced"},
		{Name = "High", Text = "High"},
	},
	Default = "Balanced",
})

UI:input(controls, {
	Label = "Text",
	Placeholder = "Try the input component",
	Size = UDim2.fromScale(0.94, 0.13),
	Position = UDim2.fromScale(0.03, 0.73),
})

local themes = makePage("Themes")
UI:createText(themes, "Themes", {
	Size = UDim2.fromScale(0.9, 0.07),
	Position = UDim2.fromScale(0.03, 0.01),
	TextSize = 22,
	Font = Enum.Font.GothamBold,
})

UI:createText(themes, "Switch the active palette without rebuilding the interface.", {
	Size = UDim2.fromScale(0.9, 0.05),
	Position = UDim2.fromScale(0.03, 0.075),
	TextSize = 11,
	Color = "Subtext",
})

local themeList = {
	{"Obsidian", "Deep neutral", "#9061FF"},
	{"Midnight", "Cool blue", "#4B90FF"},
	{"Carbon", "Monochrome", "#E0E1E8"},
	{"Violet", "Rich violet", "#B259FF"},
}

for i, item in ipairs(themeList) do
	local y = 0.17 + (i - 1) * 0.17
	local row = UI:card(themes, {
		Size = UDim2.fromScale(0.94, 0.14),
		Position = UDim2.fromScale(0.03, y),
		Color = "Surface",
		Radius = 10,
	})

	local swatch = UI:createFrame(row, {
		Size = UDim2.fromScale(0.06, 0.42),
		Position = UDim2.fromScale(0.045, 0.29),
		Color = "Accent",
		Radius = 99,
	})

	UI:createText(row, item[1], {
		Size = UDim2.fromScale(0.45, 0.38),
		Position = UDim2.fromScale(0.14, 0.12),
		TextSize = 12,
		Font = Enum.Font.GothamMedium,
	})

	UI:createText(row, item[2], {
		Size = UDim2.fromScale(0.45, 0.28),
		Position = UDim2.fromScale(0.14, 0.53),
		TextSize = 9,
		Color = "Muted",
	})

	UI:button(row, {
		Text = "Apply",
		Size = UDim2.fromScale(0.2, 0.55),
		Position = UDim2.fromScale(0.75, 0.23),
		Color = "SurfaceAlt",
		Radius = 8,
		OnClick = function()
			UI:setTheme(item[1])
			UI:notify({
				Title = "Theme changed",
				Text = item[1] .. " is now active.",
				Type = "Info",
			})
		end,
	})
end

local about = makePage("About")
UI:createText(about, "About StarGaze", {
	Size = UDim2.fromScale(0.9, 0.07),
	Position = UDim2.fromScale(0.03, 0.01),
	TextSize = 22,
	Font = Enum.Font.GothamBold,
})

local aboutCard = UI:glass(about, {
	Size = UDim2.fromScale(0.94, 0.28),
	Position = UDim2.fromScale(0.03, 0.14),
	Color = "Glass",
	Radius = 12,
})

UI:createText(aboutCard, "StarGaze", {
	Size = UDim2.fromScale(0.82, 0.2),
	Position = UDim2.fromScale(0.07, 0.12),
	TextSize = 17,
	Font = Enum.Font.GothamBold,
})

UI:createText(aboutCard, "A modular UI framework for Roblox with reusable components, responsive composition, interaction states, and themeable visual systems.", {
	Size = UDim2.fromScale(0.82, 0.42),
	Position = UDim2.fromScale(0.07, 0.38),
	TextSize = 11,
	Color = "Subtext",
	TextWrapped = true,
	TextYAlignment = Enum.TextYAlignment.Top,
})

UI:badge(aboutCard, {
	Text = "OPEN SOURCE",
	Size = UDim2.fromScale(0.2, 0.16),
	Position = UDim2.fromScale(0.07, 0.75),
	Color = "Success",
})

selectPage("Overview")
for name, button in pairs(navButtons) do
	local indicator = button:FindFirstChild("Indicator")
	if indicator then
		indicator.Visible = name == "Overview"
	end
end

window:open()

UI:notify({
	Title = "StarGaze",
	Text = "Showcase ready.",
	Type = "Info",
	Duration = 3,
})


local density = UI:setting("Density")
UI:configure({
\tDensity = density,
\tTextScale = 1,
\tHover = true,
\tPress = true,
\tTooltips = true,
})

UI:registerStyle("ExampleStyle", {
\tRadius = 9,
\tStrokeTransparency = 0.3,
\tHoverStrength = 0.04,
\tPressScale = 0.985,
\tShadow = false,
})

UI:registerPlugin(require(script.Parent.Plugin))
