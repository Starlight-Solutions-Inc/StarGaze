local Utils=require(script.Parent.Parent.Utils)
local Toggle={}; Toggle.__index=Toggle
function Toggle.new(runtime,parent,options)
	options=options or {}
	local holder=runtime:card(parent,{Name=options.Name or "Toggle",Size=options.Size or UDim2.new(1,0,0,48),Color=options.Background or "Card",CornerRadius=options.CornerRadius or 10})
	runtime:createText(holder,options.Text or "Toggle",{Size=UDim2.new(1,-68,1,0),Position=UDim2.fromOffset(14,0),TextSize=options.TextSize or 14})
	local switch=Utils.create("TextButton",{BackgroundColor3=runtime.Theme.SurfaceAlt,BorderSizePixel=0,Size=UDim2.fromOffset(42,24),Position=UDim2.new(1,-54,.5,-12),Text="",AutoButtonColor=false,Parent=holder})
	Utils.corner(switch,999)
	local knob=Utils.create("Frame",{BackgroundColor3=runtime.Theme.Text,BorderSizePixel=0,Size=UDim2.fromOffset(18,18),Position=UDim2.fromOffset(3,3),Parent=switch})
	Utils.corner(knob,999)
	local self=setmetatable({Runtime=runtime,Instance=holder,Switch=switch,Knob=knob,Value=options.Default==true},Toggle)
	self:update(self.Value)
	runtime:track(holder); runtime:track(switch); runtime:track(knob)
	runtime:connect(switch.Activated:Connect(function() self:set(not self.Value) end))
	return self
end
function Toggle:update(value)
	self.Value=value==true
	self.Runtime:animate(self.Switch,{BackgroundColor3=self.Value and self.Runtime.Theme.Accent or self.Runtime.Theme.SurfaceAlt})
	self.Runtime:animate(self.Knob,{Position=self.Value and UDim2.new(1,-21,0,3) or UDim2.fromOffset(3,3)})
	if self.OnChanged then self.OnChanged(self.Value) end
	return self
end
function Toggle:set(value) return self:update(value) end
function Toggle:get() return self.Value end
function Toggle:toggle() return self:update(not self.Value) end
function Toggle:changed(callback) self.OnChanged=callback; return self end
return Toggle
