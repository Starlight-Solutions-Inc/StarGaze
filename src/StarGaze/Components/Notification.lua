local Utils=require(script.Parent.Parent.Core.Utils)
local Notification={};Notification.__index=Notification
local colors={Success="Success",Warning="Warning",Danger="Danger",Info="Info",Default="Accent"}
function Notification.new(runtime,options)
	options=options or {}
	local layer=runtime:getLayer("Notifications")
	if not layer then
		layer=Utils.create("Frame",{BackgroundTransparency=1,Size=UDim2.fromScale(0.31,0.92),Position=UDim2.fromScale(0.67,0.04),Parent=runtime.Gui,ZIndex=300})
		Utils.list(layer,{HorizontalAlignment=Enum.HorizontalAlignment.Right,VerticalAlignment=Enum.VerticalAlignment.Top,Padding=UDim.new(0,8)})
		runtime:track(layer);runtime:registerLayer("Notifications",layer)
	end
	local card=runtime:createFrame(layer,{Size=options.Size or UDim2.fromScale(0.98,0.095),Color=options.Color or "Surface",Transparency=options.Transparency or 0,Radius=12,Stroke=true,StrokeTransparency=0.4,ZIndex=301})
	local accent=Utils.create("Frame",{Size=UDim2.fromScale(0.012,0.78),Position=UDim2.fromScale(0.035,0.11),BackgroundColor3=Utils.color(colors[options.Type or "Default"] or "Accent",runtime.Theme),BorderSizePixel=0,Parent=card})
	Utils.corner(accent,999)
	runtime:createText(card,options.Title or "Notification",{Size=UDim2.fromScale(0.88,0.28),Position=UDim2.fromScale(0.085,0.1),TextSize=13})
	runtime:createText(card,options.Text or "",{Size=UDim2.fromScale(0.88,0.46),Position=UDim2.fromScale(0.085,0.4),TextSize=11,Color="Subtext",TextWrapped=true,TextYAlignment=Enum.TextYAlignment.Top})
	local self=setmetatable({Runtime=runtime,Instance=card},Notification)
	runtime:animate(card,{Position=UDim2.fromScale(0,0)},0.2,Enum.EasingStyle.Quint)
	task.delay(options.Duration or 4,function() if card.Parent then self:close() end end)
	return self
end
function Notification:close()
	local tween=self.Runtime:animate(self.Instance,{BackgroundTransparency=1},0.18)
	tween.Completed:Connect(function() if self.Instance.Parent then self.Instance:Destroy() end end)
end
return Notification
