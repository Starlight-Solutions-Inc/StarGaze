local Utils = require(script.Parent.Parent.Core.Utils)

local Slider = {}
Slider.__index = Slider

function Slider.new(runtime, parent, options)
	options = options or {}
	local min,max=options.Min or 0, options.Max or 100
	local value=math.clamp(options.Default or min,min,max)
	local holder=runtime:card(parent,{Size=options.Size or UDim2.fromScale(1,0.14),Color=options.Background or "Card",Radius=options.Radius or 10})
	runtime:createText(holder,options.Text or "Slider",{Size=UDim2.fromScale(0.72,0.36),Position=UDim2.fromScale(0.04,0.04),TextSize=options.TextSize or 14})
	local valueText=runtime:createText(holder,tostring(value),{Size=UDim2.fromScale(0.2,0.36),Position=UDim2.fromScale(0.76,0.04),TextSize=12,TextXAlignment=Enum.TextXAlignment.Right,Color="Subtext"})
	local bar=Utils.create("Frame",{BackgroundColor3=runtime.Theme.SurfaceAlt,BorderSizePixel=0,Size=UDim2.fromScale(0.92,0.1),Position=UDim2.fromScale(0.04,0.72),Parent=holder})
	Utils.corner(bar,999)
	local fill=Utils.create("Frame",{BackgroundColor3=runtime.Theme.Accent,BorderSizePixel=0,Size=UDim2.fromScale(0,1),Parent=bar})
	Utils.corner(fill,999)
	local button=Utils.button(bar)
	local drag=false
	local self=setmetatable({Runtime=runtime,Instance=holder,Bar=bar,Fill=fill,Value=value,Min=min,Max=max,ValueText=valueText,Formatter=options.Format},Slider)
	runtime:track(holder);runtime:track(bar);runtime:track(fill);runtime:track(button)
	local function update(input)
		local alpha=math.clamp((input.Position.X-bar.AbsolutePosition.X)/math.max(bar.AbsoluteSize.X,1),0,1)
		self:set(min+(max-min)*alpha)
	end
	runtime:connect(button.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then drag=true;update(input) end end))
	runtime:connect(game:GetService("UserInputService").InputChanged:Connect(function(input) if drag and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then update(input) end end))
	runtime:connect(game:GetService("UserInputService").InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then drag=false end end))
	self:set(value,true)
	return self
end
function Slider:set(value,silent)
	self.Value=math.clamp(value,self.Min,self.Max)
	local alpha=(self.Value-self.Min)/math.max(self.Max-self.Min,0.00001)
	self.Runtime:animate(self.Fill,{Size=UDim2.fromScale(alpha,1)},0.08)
	self.ValueText.Text=self.Formatter and self.Formatter(self.Value) or tostring(math.floor(self.Value*100)/100)
	if self.OnChanged and not silent then self.OnChanged(self.Value) end
	return self
end
function Slider:get() return self.Value end
function Slider:changed(callback) self.OnChanged=callback return self end
function Slider:format(callback) self.Formatter=callback return self end
return Slider
