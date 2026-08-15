local Utils = {}

function Utils.merge(...)
	local result = {}
	for _, source in ipairs({...}) do
		if source then
			for key, value in pairs(source) do
				if type(value) == "table" and type(result[key]) == "table" then
					result[key] = Utils.merge(result[key], value)
				else
					result[key] = value
				end
			end
		end
	end
	return result
end

function Utils.create(className, properties)
	local instance = Instance.new(className)
	for property, value in pairs(properties or {}) do
		instance[property] = value
	end
	return instance
end

function Utils.color(value, theme)
	if typeof(value) == "Color3" then
		return value
	end
	if type(value) == "string" and theme[value] then
		return theme[value]
	end
	if type(value) == "string" then
		return theme.Text or Color3.new(1, 1, 1)
	end
	return value
end

function Utils.corner(parent, radius)
	return Utils.create("UICorner", {
		CornerRadius = UDim.new(0, radius or 10),
		Parent = parent,
	})
end

function Utils.stroke(parent, color, transparency, thickness)
	return Utils.create("UIStroke", {
		Color = color,
		Transparency = transparency or 0,
		Thickness = thickness or 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = parent,
	})
end

function Utils.aspect(parent, ratio)
	return Utils.create("UIAspectRatioConstraint", {
		AspectRatio = ratio,
		Parent = parent,
	})
end

function Utils.scale(parent, value)
	return Utils.create("UIScale", {
		Scale = value or 1,
		Parent = parent,
	})
end

function Utils.padding(parent, top, right, bottom, left)
	return Utils.create("UIPadding", {
		PaddingTop = UDim.new(0, top or 0),
		PaddingRight = UDim.new(0, right or top or 0),
		PaddingBottom = UDim.new(0, bottom or top or 0),
		PaddingLeft = UDim.new(0, left or right or top or 0),
		Parent = parent,
	})
end

function Utils.list(parent, options)
	options = options or {}
	return Utils.create("UIListLayout", {
		FillDirection = options.Direction or Enum.FillDirection.Vertical,
		HorizontalAlignment = options.HorizontalAlignment or Enum.HorizontalAlignment.Left,
		VerticalAlignment = options.VerticalAlignment or Enum.VerticalAlignment.Top,
		Padding = options.Padding or UDim.new(0, 8),
		SortOrder = options.SortOrder or Enum.SortOrder.LayoutOrder,
		Wraps = options.Wraps or false,
		Parent = parent,
	})
end

function Utils.text(parent, text, theme, options)
	options = options or {}
	return Utils.create("TextLabel", {
		BackgroundTransparency = 1,
		Size = options.Size or UDim2.fromScale(1, 1),
		Position = options.Position or UDim2.fromScale(0, 0),
		AnchorPoint = options.AnchorPoint or Vector2.zero,
		Text = tostring(text or ""),
		TextColor3 = Utils.color(options.Color or "Text", theme),
		TextSize = options.TextSize or 14,
		TextScaled = options.TextScaled or false,
		AutomaticSize = options.AutomaticSize or Enum.AutomaticSize.None,
		Font = options.Font or Enum.Font.Gotham,
		TextXAlignment = options.TextXAlignment or Enum.TextXAlignment.Left,
		TextYAlignment = options.TextYAlignment or Enum.TextYAlignment.Center,
		TextWrapped = options.TextWrapped or false,
		RichText = options.RichText or false,
		Parent = parent,
	})
end

function Utils.button(parent)
	return Utils.create("TextButton", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		AutoButtonColor = false,
		Parent = parent,
	})
end

return Utils
