local Utils = require(script.Parent.Core.Utils)

local Elements = {}
Elements.__index = Elements

function Elements.new(runtime)
	return setmetatable({Runtime = runtime}, Elements)
end

function Elements:frame(parent, options)
	options = options or {}
	local theme = self.Runtime.Theme
	local frame = Utils.create("Frame", {
		Name = options.Name or "Frame",
		BackgroundColor3 = Utils.color(options.Color or "Surface", theme),
		BackgroundTransparency = options.Transparency or 0,
		BorderSizePixel = 0,
		Size = options.Size or UDim2.fromScale(1, 1),
		Position = options.Position or UDim2.fromScale(0, 0),
		AnchorPoint = options.AnchorPoint or Vector2.zero,
		Visible = options.Visible ~= false,
		ClipsDescendants = options.ClipsDescendants or false,
		ZIndex = options.ZIndex or 1,
		Parent = parent or self.Runtime.Gui,
	})
	Utils.corner(frame, options.Radius or 10)
	if options.Stroke then
		Utils.stroke(frame, Utils.color(options.StrokeColor or "Border", theme), options.StrokeTransparency or 0, options.StrokeThickness or 1)
	end
	if options.Padding then
		Utils.padding(frame, options.Padding.Top, options.Padding.Right, options.Padding.Bottom, options.Padding.Left)
	end
	self.Runtime:track(frame)
	return frame
end

function Elements:text(parent, text, options)
	options = options or {}
	local element = Utils.text(parent or self.Runtime.Gui, text, self.Runtime.Theme, {
		Name = options.Name,
		Size = options.Size or UDim2.fromScale(1, 1),
		Position = options.Position or UDim2.fromScale(0, 0),
		AnchorPoint = options.AnchorPoint or Vector2.zero,
		Color = options.Color or "Text",
		TextSize = options.TextSize or 14,
		TextScaled = options.TextScaled,
		AutomaticSize = options.AutomaticSize,
		Font = options.Font or self.Runtime.Options.Font,
		TextXAlignment = options.TextXAlignment,
		TextYAlignment = options.TextYAlignment,
		TextWrapped = options.TextWrapped,
		RichText = options.RichText,
	})
	element.Name = options.Name or "Text"
	self.Runtime:track(element)
	return element
end

function Elements:container(parent, options)
	options = options or {}
	local container = self:frame(parent, options)
	if options.Layout then
		Utils.list(container, options.Layout)
	end
	return container
end

return Elements
