local Utils=require(script.Parent.Parent.Utils)
local Notification={}; Notification.__index=Notification
local types={Success="Success",Warning="Warning",Danger="Danger",Info="Info",Default="Accent"}
function Notification.new(runtime,options)
	options=options or {}
	if not runtime.NotificationContainer then
		runtime.NotificationContainer=Utils.create("Frame",{Name="Notifications",BackgroundTransparency=1,Size=UDim2.new(0,320,1,-30),Position=UDim2.new(1,-340,0,15),ZIndex=100,Parent=runtime.Gui})
		Utils.create("UIListLayout",{HorizontalAlignment=Enum.HorizontalAlignment.Right,VerticalAlignment=Enum.VerticalAlignment.Top,Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=runtime.NotificationContainer}); runtime:track(runtime.NotificationContainer)
	end
	local instance=Utils.create("Frame",{BackgroundColor3=Utils.resolveColor(options.Color or "Surface",runtime.Theme),BackgroundTransparency=options.Transparency or 0,BorderSizePixel=0,Size=UDim2.fromOffset(300,options.Height or 76),Position=UDim2.fromOffset(340,0),ZIndex=101,Parent=runtime.NotificationContainer}); Utils.corner(instance,options.CornerRadius or 12); Utils.stroke(instance,Utils.resolveColor("Border",runtime.Theme),.25)
	local accent=Utils.create("Frame",{BackgroundColor3=Utils.resolveColor(types[options.Type or "Default"] or "Accent",runtime.Theme),BorderSizePixel=0,Size=UDim2.new(0,3,1,-16),Position=UDim2.fromOffset(8,8),Parent=instance}); Utils.corner(accent,999)
	runtime:createText(instance,options.Title or "Notification",{Size=UDim2.new(1,-40,0,24),Position=UDim2.fromOffset(22,10),TextSize=options.TitleSize or 14})
	runtime:createText(instance,options.Text or "",{Size=UDim2.new(1,-40,0,30),Position=UDim2.fromOffset(22,34),TextSize=options.TextSize or 12,TextWrapped=true,TextYAlignment=Enum.TextYAlignment.Top,Color="Subtext"}); runtime:track(instance); runtime:track(accent)
	runtime:animate(instance,{Position=UDim2.fromOffset(0,0)},.25,Enum.EasingStyle.Quint)
	local self=setmetatable({Runtime=runtime,Instance=instance},Notification); task.delay(options.Duration or 4,function() if instance.Parent then self:close() end end); return self
end
function Notification:close() if not self.Instance.Parent then return end; local a=self.Runtime:animate(self.Instance,{BackgroundTransparency=1},.2); a.Completed:Connect(function() if self.Instance.Parent then self.Instance:Destroy() end end) end
return Notification
