local Utils=require(script.Parent.Parent.Utils)
local Divider={}; Divider.__index=Divider
function Divider.new(runtime,parent,options)
	options=options or {}; local instance=Utils.create("Frame",{Name=options.Name or "Divider",BackgroundColor3=Utils.resolveColor(options.Color or "Border",runtime.Theme),BackgroundTransparency=options.Transparency or 0,BorderSizePixel=0,Size=options.Size or UDim2.new(1,0,0,1),Position=options.Position or UDim2.fromOffset(0,0),Parent=parent or runtime.Gui}); runtime:track(instance); return setmetatable({Runtime=runtime,Instance=instance},Divider)
end
return Divider
