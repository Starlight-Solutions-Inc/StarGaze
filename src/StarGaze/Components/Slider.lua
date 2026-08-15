local Utils=require(script.Parent.Parent.Utils)
local Slider={}; Slider.__index=Slider
function Slider.new(runtime,parent,options)
	options=options or {}; local min=options.Min or 0; local max=options.Max or 100; local initial=math.clamp(options.Default or min,min,max)
	local holder=runtime:card(parent,{Name=options.Name or "Slider",Size=options.Size or UDim2.new(1,0,0,58),Color=options.Background or "Card",CornerRadius=options.CornerRadius or 10})
	runtime:createText(holder,options.Text or "Slider",{Size=UDim2.new(.7,0,0,24),Position=UDim2.fromOffset(14,6),TextSize=options.TextSize or 14})
	local valueText=runtime:createText(holder,tostring(initial),{Size=UDim2.fromOffset(90,24),Position=UDim2.new(1,-104,0,6),TextSize=13,TextXAlignment=Enum.TextXAlignment.Right,Color="Subtext"})
	local bar=Utils.create("Frame",{BackgroundColor3=runtime.Theme.SurfaceAlt,BorderSizePixel=0,Size=UDim2.new(1,-28,0,6),Position=UDim2.new(0,14,1,-16),Parent=holder}); Utils.corner(bar,999)
	local fill=Utils.create("Frame",{BackgroundColor3=runtime.Theme.Accent,BorderSizePixel=0,Parent=bar}); Utils.corner(fill,999)
	local self=setmetatable({Runtime=runtime,Instance=holder,Bar=bar,Fill=fill,Value=initial,Min=min,Max=max,ValueText=valueText},Slider)
	runtime:track(holder); runtime:track(bar); runtime:track(fill); self:set(initial,true)
	local dragging=false
	local function update(input) local alpha=math.clamp((input.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1); self:set(min+(max-min)*alpha) end
	runtime:connect(bar.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=true; update(input) end end))
	local UIS=game:GetService("UserInputService")
	runtime:connect(UIS.InputChanged:Connect(function(input) if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then update(input) end end))
	runtime:connect(UIS.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end end))
	return self
end
function Slider:set(value,silent)
	self.Value=math.clamp(value,self.Min,self.Max); local alpha=(self.Value-self.Min)/(self.Max-self.Min)
	self.Runtime:animate(self.Fill,{Size=UDim2.new(alpha,0,1,0)},.08)
	self.ValueText.Text=self.Format and self.Format(self.Value) or tostring(math.floor(self.Value*100)/100)
	if self.OnChanged and not silent then self.OnChanged(self.Value) end
	return self
end
function Slider:get() return self.Value end
function Slider:changed(callback) self.OnChanged=callback; return self end
function Slider:format(callback) self.Format=callback; return self end
return Slider
