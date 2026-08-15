local Tooltip={}; Tooltip.__index=Tooltip
function Tooltip.new(runtime,target,options)
	options=options or {}; local instance=runtime:createFrame(runtime.Gui,{Name="Tooltip",Size=options.Size or UDim2.fromOffset(180,38),Color=options.Color or "Surface",CornerRadius=8,Stroke=true,Visible=false,ZIndex=500})
	runtime:createText(instance,options.Text or "",{Size=UDim2.new(1,-18,1,-8),Position=UDim2.fromOffset(9,4),TextSize=options.TextSize or 11,TextWrapped=true})
	local self=setmetatable({Runtime=runtime,Instance=instance},Tooltip)
	runtime:connect(target.MouseEnter:Connect(function() local p=target.AbsolutePosition; instance.Position=UDim2.fromOffset(p.X+target.AbsoluteSize.X+8,p.Y+math.floor(target.AbsoluteSize.Y/2)-math.floor(instance.AbsoluteSize.Y/2)); instance.Visible=true end))
	runtime:connect(target.MouseLeave:Connect(function() instance.Visible=false end)); return self
end
return Tooltip
