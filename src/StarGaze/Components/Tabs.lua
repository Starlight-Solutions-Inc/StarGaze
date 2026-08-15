local Utils=require(script.Parent.Parent.Utils)
local Tabs={}; Tabs.__index=Tabs
function Tabs.new(runtime,parent,options)
	options=options or {}; local root=runtime:card(parent,{Name=options.Name or "Tabs",Size=options.Size or UDim2.new(1,0,0,42),Color=options.Background or "SurfaceAlt",CornerRadius=10,ClipsDescendants=true}); Utils.padding(root,4); Utils.create("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Left,VerticalAlignment=Enum.VerticalAlignment.Center,Padding=UDim.new(0,4),Parent=root})
	local self=setmetatable({Runtime=runtime,Instance=root,Tabs={},Active=nil},Tabs); for _,definition in ipairs(options.Tabs or {}) do self:add(definition,parent,options) end; local default=options.Default or (options.Tabs[1] and options.Tabs[1].Name); if default then self:select(default) end; return self
end
function Tabs:add(definition,parent,options)
	local button=Utils.create("TextButton",{BackgroundColor3=self.Runtime.Theme.SurfaceAlt,BackgroundTransparency=1,BorderSizePixel=0,Size=definition.Size or UDim2.fromOffset(100,32),Text=definition.Text or definition.Name or "Tab",TextColor3=self.Runtime.Theme.Text,TextSize=definition.TextSize or 13,Font=self.Runtime.Options.Font,AutoButtonColor=false,Parent=self.Instance}); Utils.corner(button,8)
	local page=self.Runtime:createFrame(parent,{Name=definition.Name or "TabPage",Size=options.PageSize or UDim2.new(1,0,1,-50),Position=options.PagePosition or UDim2.fromOffset(0,50),Color=options.PageColor or "Background",CornerRadius=options.PageCornerRadius or 10,Visible=false,ClipsDescendants=true})
	self.Tabs[definition.Name]={Button=button,Page=page,Definition=definition}; self.Runtime:track(button); self.Runtime:connect(button.Activated:Connect(function() self:select(definition.Name) end)); if definition.Build then definition.Build(page,self.Runtime,self) end; return self
end
function Tabs:select(name)
	local entry=self.Tabs[name]; if not entry then return self end
	for tabName,tab in pairs(self.Tabs) do local selected=tabName==name; tab.Page.Visible=selected; self.Runtime:animate(tab.Button,{BackgroundColor3=selected and self.Runtime.Theme.Accent or self.Runtime.Theme.SurfaceAlt,BackgroundTransparency=selected and 0 or 1},.12) end
	self.Active=name; if entry.Definition.OnSelected then entry.Definition.OnSelected(entry.Page,self) end; return self
end
function Tabs:get() return self.Active end
return Tabs
