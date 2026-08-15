local Utils=require(script.Parent.Parent.Utils)
local Badge={}; Badge.__index=Badge
function Badge.new(runtime,parent,options)
	options=options or {}; local instance=Utils.create("Frame",{Name=options.Name or "Badge",BackgroundColor3=Utils.resolveColor(options.Color or "Accent",runtime.Theme),BackgroundTransparency=options.Transparency or 0,BorderSizePixel=0,Size=options.Size or UDim2.fromOffset(70,26),Parent=parent or runtime.Gui}); Utils.corner(instance,options.CornerRadius or 999)
	local text=runtime:createText(instance,options.Text or "Badge",{Size=UDim2.fromScale(1,1),TextSize=options.TextSize or 11,TextXAlignment=Enum.TextXAlignment.Center,Color=options.TextColor or "Text"}); runtime:track(instance)
	return setmetatable({Runtime=runtime,Instance=instance,Text=text},Badge)
end
function Badge:setText(value) self.Text.Text=tostring(value); return self end
function Badge:setColor(value) self.Runtime:animate(self.Instance,{BackgroundColor3=Utils.resolveColor(value,self.Runtime.Theme)}); return self end
return Badge
