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

function Utils.resolveColor(value, theme)
	if typeof(value) == "Color3" then
		return value
	end
	if type(value) == "string" then
		return theme[value] or value
	end
	return value
end

function Utils.corner(parent, radius)
	return Utils.create("UICorner", {CornerRadius = UDim.new(0, radius), Parent = parent})
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

function Utils.padding(parent, value)
	return Utils.create("UIPadding", {
		PaddingTop = UDim.new(0, value),
		PaddingBottom = UDim.new(0, value),
		PaddingLeft = UDim.new(0, value),
		PaddingRight = UDim.new(0, value),
		Parent = parent,
	})
end

function Utils.text(parent, text, options)
	options = options or {}
	return Utils.create("TextLabel", {
		BackgroundTransparency = 1,
		Size = options.Size or UDim2.fromOffset(200, 30),
		Position = options.Position or UDim2.fromOffset(0, 0),
		AnchorPoint = options.AnchorPoint or Vector2.zero,
		Text = tostring(text or ""),
		TextColor3 = options.Color,
		TextSize = options.TextSize or 14,
		Font = options.Font or Enum.Font.Gotham,
		TextXAlignment = options.TextXAlignment or Enum.TextXAlignment.Left,
		TextYAlignment = options.TextYAlignment or Enum.TextYAlignment.Center,
		TextWrapped = options.TextWrapped == true,
		RichText = options.RichText == true,
		Parent = parent,
	})
end

function Utils.bindHover(runtime, button, options)
	if options.Hover == false then
		return
	end
	local normal = button.BackgroundTransparency
	local hover = math.max(0, normal - (options.HoverStrength or 0.08))
	runtime:connect(button.MouseEnter:Connect(function()
		runtime:animate(button, {BackgroundTransparency = hover}, 0.1)
	end))
	runtime:connect(button.MouseLeave:Connect(function()
		runtime:animate(button, {BackgroundTransparency = normal}, 0.12)
	end))
end

function Utils.bindPress(runtime, button, options)
	if options.Press == false then
		return
	end
	local scale = button:FindFirstChildOfClass("UIScale")
	if not scale then
		scale = Utils.create("UIScale", {Scale = 1, Parent = button})
	end
	runtime:connect(button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			runtime:animate(scale, {Scale = options.PressScale or 0.97}, 0.08)
		end
	end))
	runtime:connect(button.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			runtime:animate(scale, {Scale = 1}, 0.1)
		end
	end))
end

return Utils
