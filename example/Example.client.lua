local StarGaze = require(game.ReplicatedStorage.StarGaze)

local UI = StarGaze.create({
	Name = "StarGazeExample",
	Theme = "Obsidian",
})

local window = UI:window({
	Name = "Main",
	Title = "StarGaze",
	Subtitle = "Starlight Solutions, Inc.",
	Size = UDim2.fromScale(0.62, 0.68),
})

UI:responsive(window.Instance, {
	BaseWidth = 1440,
	Min = 0.78,
	Max = 1.08,
})

local tabs = UI:tabs(window.Content, {
	Tabs = {
		{
			Name = "Overview",
			Text = "Overview",
			Build = function(page, api)
				local layout = api:createContainer(page, {
					Size = UDim2.fromScale(1, 1),
					Color = "Background",
					Layout = {Padding = UDim.new(0, 8)},
				})

				api:createText(layout, "A clean component showcase.", {
					Size = UDim2.fromScale(1, 0.08),
					TextSize = 18,
				})

				api:button(layout, {
					Text = "Show notification",
					Size = UDim2.fromScale(1, 0.09),
					OnClick = function()
						api:notify({
							Title = "StarGaze",
							Text = "Everything is running normally.",
							Type = "Success",
						})
					end,
				})

				api:toggle(layout, {
					Text = "Animated interactions",
					Default = true,
				})

				api:progress(layout, {
					Text = "Progress",
					Default = 0.72,
				})
			end,
		},
		{
			Name = "Controls",
			Text = "Controls",
			Build = function(page, api)
				local layout = api:createContainer(page, {
					Size = UDim2.fromScale(1, 1),
					Color = "Background",
					Layout = {Padding = UDim.new(0, 8)},
				})

				api:slider(layout, {
					Text = "Intensity",
					Min = 0,
					Max = 100,
					Default = 65,
				})

				api:dropdown(layout, {
					Text = "Theme",
					Items = {"Obsidian", "Midnight", "Carbon", "Violet"},
					Default = "Obsidian",
				}):changed(function(theme)
					api:setTheme(theme)
				end)

				api:input(layout, {
					Label = "Search",
					Placeholder = "Type something...",
				})
			end,
		},
	},
	Default = "Overview",
})

window:open()
