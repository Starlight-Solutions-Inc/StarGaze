local Utils = require(script.Parent.Parent.Core.Utils)

local Checkbox = {}
Checkbox.__index = Checkbox

function Checkbox.new(runtime, parent, options)
	options = options or {}
	local holder = runtime:card(parent, {Size = options.Size or UDim2.fromScale(1, 0.1), Color = options.Background or "Card", Radius = 10})
	local box = Utils.create("Frame", {
		BackgroundColor3 = runtime.Theme.SurfaceAlt,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(0.055, 0.55),
		Position = UDim2.fromScale(0.04, 0.225),
		Parent = holder,
	})
	Utils.corner(box, 7)
	Utils.stroke(box, runtime.Theme.Border, 0.1)
	local mark = runtime:createText(box, "✓", {Size = UDim2.fromScale(1,1), TextSize = 15, TextXAlignment = Enum.TextXAlignment.Center, Color = "Text"})
	mark.Visible = false
	local button = Utils.button(box)
	runtime:createText(holder, options.Text or "Checkbox", {Size = UDim2.fromScale(0.84,1), Position = UDim2.fromScale(0.12,0), TextSize = options.TextSize or 14})
	runtime:track(holder)
	runtime:track(box)
	runtime:track(button)
	local self = setmetatable({Runtime=runtime, Instance=holder, Box=box, Mark=mark, Value=options.Default==true}, Checkbox)
	self:update(self.Value, true)
	runtime:connect(button.Activated:Connect(function() self:update(not self.Value) end))
	return self
end

function Checkbox:update(value, silent)
	self.Value = value == true
	self.Mark.Visible = self.Value
	self.Runtime:animate(self.Box, {BackgroundColor3 = self.Value and self.Runtime.Theme.Accent or self.Runtime.Theme.SurfaceAlt})
	if self.OnChanged and not silent then self.OnChanged(self.Value) end
	return self
end
function Checkbox:set(value) return self:update(value) end
function Checkbox:get() return self.Value end
function Checkbox:changed(callback) self.OnChanged=callback return self end

return Checkbox
