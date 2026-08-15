local Utils = require(script.Parent.Utils)

local Interaction = {}

function Interaction.bind(runtime, instance, options)
	options = options or {}
	local scale = instance:FindFirstChildOfClass("UIScale") or Utils.scale(instance, 1)
	local normalColor = instance.BackgroundColor3
	local normalTransparency = instance.BackgroundTransparency
	local hoverColor = options.HoverColor and Utils.color(options.HoverColor, runtime.Theme) or normalColor
	local pressedColor = options.PressedColor and Utils.color(options.PressedColor, runtime.Theme) or hoverColor
	local hoverTransparency = options.HoverTransparency or math.max(0, normalTransparency - 0.08)
	local pressedTransparency = options.PressedTransparency or math.max(0, hoverTransparency - 0.06)

	if options.Hover ~= false then
		runtime:connect(instance.MouseEnter:Connect(function()
			runtime:animate(instance, {
				BackgroundColor3 = hoverColor,
				BackgroundTransparency = hoverTransparency,
			}, 0.12)
		end))

		runtime:connect(instance.MouseLeave:Connect(function()
			runtime:animate(instance, {
				BackgroundColor3 = normalColor,
				BackgroundTransparency = normalTransparency,
			}, 0.14)
		end))
	end

	if options.Press ~= false then
		runtime:connect(instance.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				runtime:animate(scale, {Scale = options.PressScale or 0.985}, 0.08)
				runtime:animate(instance, {
					BackgroundColor3 = pressedColor,
					BackgroundTransparency = pressedTransparency,
				}, 0.08)
			end
		end))

		runtime:connect(instance.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				runtime:animate(scale, {Scale = 1}, 0.1)
			end
		end))
	end

	return scale
end

return Interaction
