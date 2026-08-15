local Utils = require(script.Parent.Parent.Core.Utils)

local Radio = {}
Radio.__index = Radio

function Radio.new(runtime, parent, options)
	options = options or {}
	local holder = runtime:card(parent, {Size = options.Size or UDim2.fromScale(1,0.1), Color = options.Background or "Card", Radius = 10})
	local outer = Utils.create("Frame", {BackgroundColor3 = runtime.Theme.SurfaceAlt, BorderSizePixel=0, Size=UDim2.fromScale(0.055,0.55), Position=UDim2.fromScale(0.04,0.225), Parent=holder})
	Utils.corner(outer,999)
	Utils.stroke(outer,runtime.Theme.Border,0.1)
	local dot = Utils.create("Frame", {BackgroundColor3 = runtime.Theme.Accent, BorderSizePixel=0, Size=UDim2.fromScale(0.45,0.45), Position=UDim2.fromScale(0.275,0.275), Visible=false, Parent=outer})
	Utils.corner(dot,999)
	local button = Utils.button(outer)
	runtime:createText(holder, options.Text or "Option", {Size=UDim2.fromScale(0.84,1), Position=UDim2.fromScale(0.12,0), TextSize=options.TextSize or 14})
	local self = setmetatable({Runtime=runtime, Instance=holder, Dot=dot, Button=button, Value=options.Default==true}, Radio)
	self:update(self.Value,true)
	runtime:connect(button.Activated:Connect(function() self:update(true) end))
	return self
end
function Radio:update(value,silent)
	self.Value=value==true
	self.Dot.Visible=self.Value
	if self.OnChanged and not silent then self.OnChanged(self.Value,self) end
	return self
end
function Radio:set(value) return self:update(value) end
function Radio:get() return self.Value end
function Radio:changed(callback) self.OnChanged=callback return self end

function Radio:group(radios)
	for _, radio in ipairs(radios or {}) do
		if radio ~= self and radio.set then
			local original = radio.OnChanged
			radio.OnChanged = function(value, instance)
				if value then self:set(false) end
				if original then original(value, instance) end
			end
		end
	end
	return self
end

return Radio
