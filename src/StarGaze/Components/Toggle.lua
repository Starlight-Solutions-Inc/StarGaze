local Utils = require(script.Parent.Parent.Core.Utils)

local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(runtime, parent, options)
	options = options or {}
	local holder = runtime:card(parent, {
		Name = options.Name or "Toggle",
		Size = options.Size or UDim2.fromScale(1, 0.11),
		Color = options.Background or "Card",
		Radius = options.Radius or 10,
	})

	runtime:createText(holder, options.Text or "Toggle", {
		Size = UDim2.fromScale(0.72, 1),
		Position = UDim2.fromScale(0.04, 0),
		TextSize = options.TextSize or 14,
	})

	local switch = Utils.create("Frame", {
		BackgroundColor3 = runtime.Theme.SurfaceAlt,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(0.13, 0.46),
		Position = UDim2.fromScale(0.83, 0.27),
		Parent = holder,
	})
	Utils.corner(switch, 999)

	local button = Utils.button(switch)
	local knob = Utils.create("Frame", {
		BackgroundColor3 = runtime.Theme.Text,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(0.42, 0.72),
		Position = UDim2.fromScale(0.06, 0.14),
		Parent = switch,
	})
	Utils.corner(knob, 999)

	runtime:track(switch)
	runtime:track(button)
	runtime:track(knob)

	local self = setmetatable({Runtime = runtime, Instance = holder, Switch = switch, Knob = knob, Value = options.Default == true}, Toggle)
	self:update(self.Value, true)
	runtime:connect(button.Activated:Connect(function() self:update(not self.Value) end))
	return self
end

function Toggle:update(value, silent)
	self.Value = value == true
	self.Runtime:animate(self.Switch, {BackgroundColor3 = self.Value and self.Runtime.Theme.Accent or self.Runtime.Theme.SurfaceAlt})
	self.Runtime:animate(self.Knob, {Position = self.Value and UDim2.fromScale(0.52, 0.14) or UDim2.fromScale(0.06, 0.14)})
	if self.OnChanged and not silent then self.OnChanged(self.Value) end
	return self
end

function Toggle:set(value) return self:update(value) end
function Toggle:toggle() return self:update(not self.Value) end
function Toggle:get() return self.Value end
function Toggle:changed(callback) self.OnChanged = callback return self end

return Toggle
