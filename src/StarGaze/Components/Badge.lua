local Utils=require(script.Parent.Parent.Core.Utils)
local Badge={};Badge.__index=Badge
function Badge.new(runtime,parent,options)
	options=options or {}
	local holder=Utils.create("Frame",{Size=options.Size or UDim2.fromScale(0.18,0.06),BackgroundColor3=Utils.color(options.Color or "Accent",runtime.Theme),BackgroundTransparency=options.Transparency or 0,BorderSizePixel=0,Parent=parent or runtime.Gui})
	Utils.corner(holder,options.Radius or 999)
	local text=runtime:createText(holder,options.Text or "Badge",{TextSize=options.TextSize or 11,TextXAlignment=Enum.TextXAlignment.Center})
	runtime:track(holder)
	return setmetatable({Runtime=runtime,Instance=holder,Text=text},Badge)
end
function Badge:setText(value) self.Text.Text=tostring(value);return self end
function Badge:setColor(value) self.Runtime:animate(self.Instance,{BackgroundColor3=Utils.color(value,self.Runtime.Theme)});return self end
return Badge
