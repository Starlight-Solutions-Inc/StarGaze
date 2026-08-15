local StarGaze = require(game.ReplicatedStorage.StarGaze)

local UI = StarGaze.create({
	Name = "StarGazeShowcase",
	Theme = "Obsidian",
	DisplayOrder = 100,
})

local window = UI:window({
	Name = "Showcase",
	Title = "StarGaze",
	Subtitle = "A modern UI framework by Starlight Solutions, Inc.",
	Size = UDim2.fromScale(0.68, 0.76),
	Position = UDim2.fromScale(0.5, 0.5),
})

UI:responsive(window.Instance, {
	BaseWidth = 1440,
	Min = 0.8,
	Max = 1.05,
})

local tabs = UI:tabs(window.Content, {
	Default = "Overview",

	Tabs = {
		{
			Name = "Overview",
			Text = "Overview",

			Build = function(page, api)
				local layout = api:createContainer(page, {
					Size = UDim2.fromScale(1, 1),
					Color = "Background",
					Padding = 0.025,

					Layout = {
						Padding = UDim.new(0.018, 0),
					},
				})

				api:createText(layout, "StarGaze", {
					Size = UDim2.fromScale(1, 0.075),
					TextSize = 22,
				})

				api:createText(layout, "A modular Roblox UI framework focused on clean composition and reusable components.", {
					Size = UDim2.fromScale(1, 0.065),
					TextSize = 12,
					Color = "Subtext",
					TextWrapped = true,
				})

				local status = api:card(layout, {
					Size = UDim2.fromScale(1, 0.14),
					Color = "Card",
				})

				api:createText(status, "Framework status", {
					Size = UDim2.fromScale(0.7, 0.42),
					Position = UDim2.fromScale(0.035, 0.08),
					TextSize = 13,
				})

				api:createText(status, "All systems operational", {
					Size = UDim2.fromScale(0.7, 0.32),
					Position = UDim2.fromScale(0.035, 0.48),
					TextSize = 11,
					Color = "Subtext",
				})

				api:badge(status, {
					Text = "READY",
					Color = "Success",
					Size = UDim2.fromScale(0.18, 0.38),
					Position = UDim2.fromScale(0.78, 0.31),
				})

				api:progress(layout, {
					Text = "Component coverage",
					Default = 0.86,
					Size = UDim2.fromScale(1, 0.105),
				})

				api:button(layout, {
					Text = "Show notification",
					Size = UDim2.fromScale(1, 0.09),

					OnClick = function()
						api:notify({
							Title = "StarGaze",
							Text = "The framework is running correctly.",
							Type = "Success",
						})
					end,
				})

				api:button(layout, {
					Text = "Open confirmation",
					Color = "SurfaceAlt",
					Size = UDim2.fromScale(1, 0.09),

					OnClick = function()
						api:confirm({
							Title = "StarGaze confirmation",
							Text = "This is the built-in confirmation dialog component.",
							ConfirmText = "Continue",

							OnConfirm = function()
								api:notify({
									Title = "Confirmed",
									Text = "The action was accepted.",
									Type = "Info",
								})
							end,
						})
					end,
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
					Padding = 0.025,

					Layout = {
						Padding = UDim.new(0.015, 0),
					},
				})

				api:createText(layout, "Interactive Components", {
					Size = UDim2.fromScale(1, 0.065),
					TextSize = 18,
				})

				api:toggle(layout, {
					Text = "Enable animations",
					Default = true,
				}):changed(function(enabled)
					api:notify({
						Title = "Animations",
						Text = enabled and "Animations enabled." or "Animations disabled.",
						Type = "Info",
					})
				end)

				api:checkbox(layout, {
					Text = "Enable notifications",
					Default = true,
				})

				api:slider(layout, {
					Text = "Interface intensity",
					Min = 0,
					Max = 100,
					Default = 65,
				}):format(function(value)
					return string.format("%d%%", value)
				end)

				api:segmented(layout, {
					Items = {
						"Compact",
						"Balanced",
						"Comfortable",
					},
					Default = "Balanced",
				})

				api:dropdown(layout, {
					Text = "Theme",
					Items = {
						"Obsidian",
						"Midnight",
						"Carbon",
						"Violet",
					},
					Default = "Obsidian",
				}):changed(function(theme)
					api:setTheme(theme)
				end)
			end,
		},

		{
			Name = "Forms",
			Text = "Forms",

			Build = function(page, api)
				local layout = api:createContainer(page, {
					Size = UDim2.fromScale(1, 1),
					Color = "Background",
					Padding = 0.025,

					Layout = {
						Padding = UDim.new(0.018, 0),
					},
				})

				api:createText(layout, "Input Components", {
					Size = UDim2.fromScale(1, 0.065),
					TextSize = 18,
				})

				local username = api:input(layout, {
					Label = "Username",
					Placeholder = "Enter a username",
				})

				local description = api:input(layout, {
					Label = "Description",
					Placeholder = "Tell us something about yourself",
				})

				description.Field.MultiLine = true
				description.Field.TextWrapped = true

				api:button(layout, {
					Text = "Submit",
					Size = UDim2.fromScale(1, 0.09),

					OnClick = function()
						local name = username:get()

						if name == "" then
							api:notify({
								Title = "Missing information",
								Text = "Please enter a username.",
								Type = "Warning",
							})

							return
						end

						api:notify({
							Title = "Submitted",
							Text = "Welcome, " .. name .. ".",
							Type = "Success",
						})
					end,
				})

				api:divider(layout)

				api:keybind(layout, {
					Text = "Command key",
					Default = Enum.KeyCode.RightShift,
				}):listen(function(key)
					api:notify({
						Title = "Keybind",
						Text = key.Name .. " pressed.",
						Type = "Info",
					})
				end)
			end,
		},

		{
			Name = "Advanced",
			Text = "Advanced",

			Build = function(page, api)
				local layout = api:createContainer(page, {
					Size = UDim2.fromScale(1, 1),
					Color = "Background",
					Padding = 0.025,

					Layout = {
						Padding = UDim.new(0.018, 0),
					},
				})

				api:createText(layout, "Advanced Components", {
					Size = UDim2.fromScale(1, 0.065),
					TextSize = 18,
				})

				api:accordion(layout, {
					Title = "Performance",
					Text = "Runtime settings and performance-related controls.",
					Default = true,
				})

				api:accordion(layout, {
					Title = "Appearance",
					Text = "Visual customization and theme controls.",
				})

				api:colorPicker(layout, {
					Text = "Accent color",
					Default = Color3.fromRGB(142, 92, 255),
				}):changed(function(color)
					api:notify({
						Title = "Color changed",
						Text = "Accent color updated.",
						Type = "Info",
					})
				end)

				api:radio(layout, {
					Text = "Use system preference",
					Default = false,
				})

				api:radio(layout, {
					Text = "Always use dark mode",
					Default = true,
				})
			end,
		},
	},
})

local commandPalette = UI:commandPalette({
	Placeholder = "Search StarGaze...",
	Items = {
		{
			Name = "Overview",
			Action = function()
				tabs:select("Overview")
			end,
		},
		{
			Name = "Controls",
			Action = function()
				tabs:select("Controls")
			end,
		},
		{
			Name = "Forms",
			Action = function()
				tabs:select("Forms")
			end,
		},
		{
			Name = "Advanced",
			Action = function()
				tabs:select("Advanced")
			end,
		},
		{
			Name = "Midnight Theme",
			Action = function()
				UI:setTheme("Midnight")
			end,
		},
		{
			Name = "Obsidian Theme",
			Action = function()
				UI:setTheme("Obsidian")
			end,
		},
		{
			Name = "Carbon Theme",
			Action = function()
				UI:setTheme("Carbon")
			end,
		},
		{
			Name = "Violet Theme",
			Action = function()
				UI:setTheme("Violet")
			end,
		},
	},
})

window:open()

UI:notify({
	Title = "StarGaze",
	Text = "Showcase loaded successfully.",
	Type = "Success",
	Duration = 4,
})
