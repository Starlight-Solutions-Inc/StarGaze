local Utils = require(script.Parent.Parent.Core.Utils)

local Window = {}
Window.__index = Window

function Window.new(runtime, options)
	options = options or {}
	local root = runtime:glass(runtime.Gui, {
		Name = options.Name or "Window",
		Size = options.Size or UDim2.fromScale(0.62, 0.68),
		Position = options.Position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Color = options.Color or "Surface",
		Transparency = options.Transparency or 0,
		Radius = options.Radius or 16,
		Stroke = true,
		StrokeTransparency = 0.3,
		ClipsDescendants = true,
		ZIndex = options.ZIndex or 10,
	})

	local top = runtime:createFrame(root, {
		Size = UDim2.fromScale(1, 0.11),
		Color = options.TopbarColor or "SurfaceAlt",
		Radius = 0,
		ZIndex = root.ZIndex + 1,
	})

	local title = runtime:createText(top, options.Title or "StarGaze", {
		Size = UDim2.fromScale(0.68, 0.52),
		Position = UDim2.fromScale(0.035, 0.1),
		TextSize = options.TitleSize or 17,
		Font = options.TitleFont or runtime.Options.Font,
	})

	local subtitle
	if options.Subtitle then
		subtitle = runtime:createText(top, options.Subtitle, {
			Size = UDim2.fromScale(0.68, 0.3),
			Position = UDim2.fromScale(0.035, 0.57),
			TextSize = options.SubtitleSize or 10,
			Color = "Subtext",
		})
	end

	runtime:button(top, {
		Text = "×",
		Color = "Danger",
		Size = UDim2.fromScale(0.07, 0.63),
		Position = UDim2.fromScale(0.9, 0.185),
		Radius = 10,
		TextSize = 20,
		ZIndex = top.ZIndex + 2,
		OnClick = function()
			root.Visible = false
			if options.OnClose then options.OnClose() end
		end,
	})

	local content = runtime:createFrame(root, {
		Name = "Content",
		Size = UDim2.fromScale(0.94, 0.84),
		Position = UDim2.fromScale(0.03, 0.14),
		Color = options.ContentColor or "Background",
		Radius = 12,
		ClipsDescendants = true,
	})

	if options.Padding then
		Utils.padding(content, options.Padding, options.Padding, options.Padding, options.Padding)
	end

	local self = setmetatable({Runtime = runtime, Instance = root, Content = content, Title = title, Subtitle = subtitle, OriginalSize = root.Size}, Window)
	runtime.Windows[options.Name or "Window"] = self
	return self
end

function Window:open()
	self.Instance.Visible = true
	self.Instance.Size = UDim2.new(
		self.OriginalSize.X.Scale * 0.96,
		self.OriginalSize.X.Offset * 0.96,
		self.OriginalSize.Y.Scale * 0.96,
		self.OriginalSize.Y.Offset * 0.96
	)
	self.Runtime:animate(self.Instance, {Size = self.OriginalSize}, 0.22, Enum.EasingStyle.Quint)
	return self
end

function Window:close()
	self.Instance.Visible = false
	return self
end

function Window:toggle()
	if self.Instance.Visible then return self:close() end
	return self:open()
end

function Window:setTitle(value)
	self.Title.Text = tostring(value)
	return self
end

function Window:setSubtitle(value)
	if self.Subtitle then
		self.Subtitle.Text = tostring(value)
	end
	return self
end

return Window
