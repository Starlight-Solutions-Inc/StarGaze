local Utils=require(script.Parent.Parent.Core.Utils)
local Divider={};Divider.__index=Divider
function Divider.new(runtime,parent,options)
	options=options or {}
	local line=Utils.create("Frame",{Size=options.Size or UDim2.fromScale(1,0.002),Position=options.Position or UDim2.fromScale(0,0),BackgroundColor3=Utils.color(options.Color or "BorderSoft",runtime.Theme),BackgroundTransparency=options.Transparency or 0,BorderSizePixel=0,Parent=parent or runtime.Gui})
	runtime:track(line);return setmetatable({Runtime=runtime,Instance=line},Divider)
end
return Divider
