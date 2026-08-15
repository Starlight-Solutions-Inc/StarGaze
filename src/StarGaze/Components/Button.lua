local Utils = require(script.Parent.Parent.Core.Utils)
local Interaction = require(script.Parent.Parent.Core.Interaction)

local Button = {}
Button.__index = Button

function Button.new(runtime, parent, options)
	options = options or {}
	local theme = runtime.Theme
	local holder = Utils.create("Frame", {
		Name = options.Name or "Button",
		BackgroundColor3 = Utils.color(options.Color or "Accent", theme),
		BackgroundTransparency = options.Transparency or 0,
		BorderSizePixel = 0,
		Size = options.Size or UDim2.fromScale(1, 0.1),
		Position = options.Position or UDim2.fromScale(0, 0),
		Parent = parent or runtime.Gui,
	})
	Utils.corner(holder, options.Radius or 10)
	if options.Stroke then
		Utils.stroke(holder, Utils.color(options.StrokeColor or "Border", theme), options.StrokeTransparency or 0)
	end

	local button = Utils.button(holder)
	local text = Utils.text(holder, options.Text or "Button", theme, {
		Size = UDim2.fromScale(1, 1),
		TextSize = options.TextSize or 14,
		Color = options.TextColor or "Text",
		Font = options.Font or runtime.Options.Font,
		TextXAlignment = options.TextXAlignment or Enum.TextXAlignment.Center,
	})

	if options.Icon then
		local icon = Utils.create("ImageLabel", {
			BackgroundTransparency = 1,
			Image = options.Icon,
			ImageColor3 = Utils.color(options.IconColor or "Text", theme),
			Size = UDim2.fromScale(0.09, 0.5),
			Position = UDim2.fromScale(0.06, 0.25),
			ScaleType = Enum.ScaleType.Fit,
			Parent = holder,
		})
		runtime:track(icon)
		text.Size = UDim2.fromScale(0.79, 1)
		text.Position = UDim2.fromScale(0.16, 0)
	end

	runtime:track(holder)
	runtime:track(button)
	runtime:track(text)
	Interaction.bind(runtime, button, options)

	local self = setmetatable({Runtime = runtime, Instance = holder, Button = button, Text = text}, Button)
	if options.OnClick then
		self:connect(options.OnClick)
	end
	return self
end

function Button:connect(callback)
	return self.Runtime:connect(self.Button.Activated:Connect(function()
		callback(self)
	end))
end

function Button:setText(text)
	self.Text.Text = tostring(text)
	return self
end

function Button:setColor(value)
	self.Runtime:animate(self.Instance, {
		BackgroundColor3 = Utils.color(value, self.Runtime.Theme),
	}, 0.12)
	return self
end

function Button:setVisible(value)
	self.Instance.Visible = value == true
	return self
end

function Button:destroy()
	if self.Instance.Parent then self.Instance:Destroy() end
end

return Button
