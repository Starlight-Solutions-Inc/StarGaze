local Utils=require(script.Parent.Parent.Core.Utils)
local Tabs={};Tabs.__index=Tabs
function Tabs.new(runtime,parent,options)
	options=options or {}
	local root=runtime:card(parent,{Size=options.Size or UDim2.fromScale(1,1),Color=options.Color or "Background",Radius=options.Radius or 10})
	local header=runtime:createFrame(root,{Size=UDim2.fromScale(1,0.12),Color=options.HeaderColor or "SurfaceAlt",Radius=10})
	Utils.padding(header,0,0,0,0);Utils.list(header,{Direction=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Left,VerticalAlignment=Enum.VerticalAlignment.Center,Padding=UDim.new(0,4),Wraps=true})
	local pageHolder=runtime:createFrame(root,{Size=UDim2.fromScale(1,0.84),Position=UDim2.fromScale(0,0.15),Color=options.PageColor or "Background",Radius=10})
	local self=setmetatable({Runtime=runtime,Instance=root,Header=header,Pages=pageHolder,Items={},Active=nil},Tabs)
	for _,def in ipairs(options.Tabs or {}) do self:add(def) end
	local first=options.Default or (options.Tabs[1] and options.Tabs[1].Name)
	if first then self:select(first) end
	return self
end
function Tabs:add(def)
	local button=Utils.create("TextButton",{BackgroundColor3=self.Runtime.Theme.SurfaceAlt,BackgroundTransparency=1,BorderSizePixel=0,Size=def.Size or UDim2.fromScale(0.16,0.74),Text=def.Text or def.Name,TextColor3=self.Runtime.Theme.Text,TextSize=def.TextSize or 12,Font=self.Runtime.Options.Font,AutoButtonColor=false,Parent=self.Header})
	Utils.corner(button,8)
	local page=self.Runtime:createFrame(self.Pages,{Name=def.Name,Size=UDim2.fromScale(1,1),Color=def.Color or "Background",Radius=0,Visible=false})
	local entry={Button=button,Page=page,Definition=def};self.Items[def.Name]=entry
	self.Runtime:track(button);self.Runtime:connect(button.Activated:Connect(function() self:select(def.Name) end))
	if def.Build then def.Build(page,self.Runtime,self) end
	return self
end
function Tabs:select(name)
	local entry=self.Items[name];if not entry then return self end
	for key,item in pairs(self.Items) do
		local active=key==name;item.Page.Visible=active
		self.Runtime:animate(item.Button,{BackgroundColor3=active and self.Runtime.Theme.Accent or self.Runtime.Theme.SurfaceAlt,BackgroundTransparency=active and 0 or 1},0.12)
	end
	self.Active=name
	if entry.Definition.OnSelected then entry.Definition.OnSelected(entry.Page,self) end
	return self
end
function Tabs:get() return self.Active end
return Tabs
