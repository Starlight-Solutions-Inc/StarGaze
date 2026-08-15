local Utils=require(script.Parent.Parent.Utils)
local Window={}; Window.__index=Window
function Window.new(runtime,options)
	options=options or {}; local instance=runtime:card(runtime.Gui,{Name=options.Name or "Window",Size=options.Size or UDim2.fromOffset(620,420),Position=options.Position or UDim2.fromScale(.5,.5),AnchorPoint=Vector2.new(.5,.5),Color=options.Color or "Surface",CornerRadius=options.CornerRadius or 14,Stroke=options.Stroke~=false,StrokeColor=options.StrokeColor or "Border",ClipsDescendants=true,ZIndex=options.ZIndex or 5})
	local topbar=runtime:createFrame(instance,{Name="Topbar",Size=UDim2.new(1,0,0,54),Color=options.TopbarColor or "SurfaceAlt",CornerRadius=0,ZIndex=6})
	local title=runtime:createText(topbar,options.Title or "StarGaze",{Size=UDim2.new(1,-120,1,0),Position=UDim2.fromOffset(18,0),TextSize=options.TitleSize or 16})
	local subtitle
	if options.Subtitle then subtitle=runtime:createText(topbar,options.Subtitle,{Size=UDim2.new(1,-120,0,16),Position=UDim2.fromOffset(18,29),TextSize=10,Color="Subtext"}) end
	runtime:button(topbar,{Text="×",Color="Danger",Size=UDim2.fromOffset(34,34),Position=UDim2.new(1,-44,0,10),CornerRadius=9,TextSize=18,OnClick=function() if options.OnClose then options.OnClose() end instance.Visible=false end})
	local content=runtime:createFrame(instance,{Name="Content",Size=UDim2.new(1,0,1,-54),Position=UDim2.fromOffset(0,54),Color=options.ContentColor or "Background",CornerRadius=0,ZIndex=5}); if options.Padding then Utils.padding(content,options.Padding) end
	if options.Layout then Utils.create("UIListLayout",{FillDirection=options.Layout.FillDirection or Enum.FillDirection.Vertical,HorizontalAlignment=options.Layout.HorizontalAlignment or Enum.HorizontalAlignment.Left,VerticalAlignment=options.Layout.VerticalAlignment or Enum.VerticalAlignment.Top,Padding=options.Layout.Padding or UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=content}) end
	local self=setmetatable({Runtime=runtime,Instance=instance,Content=content,Title=title,Subtitle=subtitle,OriginalSize=instance.Size},Window); runtime:track(instance); runtime.Windows[options.Name or "Window"]=self; return self
end
function Window:open() self.Instance.Visible=true; self.Instance.Size=UDim2.new(self.OriginalSize.X.Scale,math.floor(self.OriginalSize.X.Offset*.96),self.OriginalSize.Y.Scale,math.floor(self.OriginalSize.Y.Offset*.96)); self.Runtime:animate(self.Instance,{Size=self.OriginalSize},.22,Enum.EasingStyle.Quint); return self end
function Window:close() self.Instance.Visible=false; return self end
function Window:toggle() if self.Instance.Visible then return self:close() else return self:open() end end
function Window:setTitle(value) self.Title.Text=tostring(value); return self end
return Window
