local Utils = require(script.Parent.Parent.Core.Utils)
local Progress = {}
Progress.__index=Progress
function Progress.new(runtime,parent,options)
	options=options or {}
	local holder=runtime:card(parent,{Size=options.Size or UDim2.fromScale(1,0.1),Color=options.Background or "Card",Radius=options.Radius or 10})
	runtime:createText(holder,options.Text or "Progress",{Size=UDim2.fromScale(0.24,1),Position=UDim2.fromScale(0.04,0),TextSize=options.TextSize or 13})
	local bar=Utils.create("Frame",{BackgroundColor3=runtime.Theme.SurfaceAlt,BorderSizePixel=0,Size=UDim2.fromScale(0.58,0.28),Position=UDim2.fromScale(0.31,0.36),Parent=holder})
	Utils.corner(bar,999)
	local fill=Utils.create("Frame",{BackgroundColor3=Utils.color(options.Color or "Accent",runtime.Theme),BorderSizePixel=0,Size=UDim2.fromScale(0,1),Parent=bar})
	Utils.corner(fill,999)
	local valueText=runtime:createText(holder,"0%",{Size=UDim2.fromScale(0.08,1),Position=UDim2.fromScale(0.9,0),TextSize=11,TextXAlignment=Enum.TextXAlignment.Right,Color="Subtext"})
	runtime:track(holder);runtime:track(bar);runtime:track(fill)
	local self=setmetatable({Runtime=runtime,Instance=holder,Fill=fill,ValueText=valueText,Value=0},Progress)
	self:set(options.Default or 0)
	return self
end
function Progress:set(value)
	self.Value=math.clamp(value,0,1)
	self.Runtime:animate(self.Fill,{Size=UDim2.fromScale(self.Value,1)},0.15)
	self.ValueText.Text=tostring(math.floor(self.Value*100+0.5)).."%"
	return self
end
function Progress:get() return self.Value end
return Progress
