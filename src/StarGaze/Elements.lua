local Utils = require(script.Parent.Utils)

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
		BackgroundColor3 = Utils.resolveColor(options.Color or "Surface", theme),
		BackgroundTransparency = options.Transparency or 0,
		BorderSizePixel = 0,
		Size = options.Size or UDim2.fromScale(1, 1),
		Position = options.Position or UDim2.fromOffset(0, 0),
		AnchorPoint = options.AnchorPoint or Vector2.zero,
		Visible = options.Visible ~= false,
		ClipsDescendants = options.ClipsDescendants == true,
		ZIndex = options.ZIndex or 1,
		Parent = parent or self.Runtime.Gui,
	})
	if options.CornerRadius ~= 0 then Utils.corner(frame, options.CornerRadius or 10) end
	if options.Stroke then Utils.stroke(frame, Utils.resolveColor(options.StrokeColor or "Border", theme), options.StrokeTransparency or 0, options.StrokeThickness or 1) end
	if options.Padding then Utils.padding(frame, options.Padding) end
	self.Runtime:track(frame)
	return frame
end

function Elements:text(parent, text, options)
	options = options or {}
	local element = Utils.text(parent or self.Runtime.Gui, text, {
		Size = options.Size or UDim2.fromOffset(200, 30), Position = options.Position or UDim2.fromOffset(0, 0), AnchorPoint = options.AnchorPoint or Vector2.zero,
		Color = Utils.resolveColor(options.Color or "Text", self.Runtime.Theme), TextSize = options.TextSize or 14, Font = options.Font or self.Runtime.Options.Font,
		TextXAlignment = options.TextXAlignment, TextYAlignment = options.TextYAlignment, TextWrapped = options.TextWrapped, RichText = options.RichText,
	})
	element.Name = options.Name or "Text"
	element.TextTransparency = options.TextTransparency or 0
	element.ZIndex = options.ZIndex or 1
	self.Runtime:track(element)
	return element
end

function Elements:container(parent, options)
	options = options or {}
	local container = self:frame(parent, options)
	if options.Layout then
		Utils.create("UIListLayout", {
			FillDirection = options.Layout.FillDirection or Enum.FillDirection.Vertical,
			HorizontalAlignment = options.Layout.HorizontalAlignment or Enum.HorizontalAlignment.Left,
			VerticalAlignment = options.Layout.VerticalAlignment or Enum.VerticalAlignment.Top,
			Padding = options.Layout.Padding or UDim.new(0, 8),
			SortOrder = options.Layout.SortOrder or Enum.SortOrder.LayoutOrder,
			Parent = container,
		})
	end
	return container
end

return Elements
