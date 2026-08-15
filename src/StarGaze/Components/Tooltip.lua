local Utils=require(script.Parent.Parent.Core.Utils)
local Tooltip={};Tooltip.__index=Tooltip
function Tooltip.new(runtime,target,options)
	options=options or {}
	local tip=runtime:createFrame(runtime.Gui,{Size=options.Size or UDim2.fromScale(0.16,0.06),Color=options.Color or "Surface",Radius=8,Stroke=true,Visible=false,ZIndex=500})
	runtime:createText(tip,options.Text or "",{Size=UDim2.fromScale(0.94,0.9),Position=UDim2.fromScale(0.03,0.05),TextSize=10,TextWrapped=true})
	local self=setmetatable({Runtime=runtime,Instance=tip},Tooltip)
	runtime:connect(target.MouseEnter:Connect(function()
		local pos=target.AbsolutePosition;local root=runtime.Gui.AbsoluteSize
		local sx=(pos.X+target.AbsoluteSize.X+8)/math.max(root.X,1);local sy=(pos.Y+target.AbsoluteSize.Y*0.5)/math.max(root.Y,1)
		tip.Position=UDim2.fromScale(math.clamp(sx,0.01,0.84),math.clamp(sy,0.02,0.92));tip.Visible=true
	end))
	runtime:connect(target.MouseLeave:Connect(function() tip.Visible=false end))
	return self
end
return Tooltip
