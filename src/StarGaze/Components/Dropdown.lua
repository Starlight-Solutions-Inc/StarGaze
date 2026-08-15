local Utils=require(script.Parent.Parent.Utils)
local Dropdown={}; Dropdown.__index=Dropdown
function Dropdown.new(runtime,parent,options)
	options=options or {}
	local holder=runtime:card(parent,{Name=options.Name or "Dropdown",Size=options.Size or UDim2.new(1,0,0,46),Color=options.Background or "Card",CornerRadius=options.CornerRadius or 10,ClipsDescendants=false})
	local button=Utils.create("TextButton",{BackgroundTransparency=1,Size=UDim2.fromScale(1,1),Text="",AutoButtonColor=false,Parent=holder})
	runtime:createText(button,options.Text or "Select",{Size=UDim2.new(1,-210,1,0),Position=UDim2.fromOffset(14,0)})
	local selected=runtime:createText(button,options.Default or "Choose...",{Size=UDim2.new(0,155,1,0),Position=UDim2.new(1,-194,0,0),TextSize=13,TextXAlignment=Enum.TextXAlignment.Right,Color="Subtext"})
	local arrow=runtime:createText(button,"⌄",{Size=UDim2.fromOffset(30,1),Position=UDim2.new(1,-36,0,0),TextSize=18,TextXAlignment=Enum.TextXAlignment.Center,Color="Subtext"})
	local list=runtime:createFrame(holder,{Name="List",Size=UDim2.new(1,0,0,0),Position=UDim2.new(0,0,1,6),Color="Surface",CornerRadius=10,Stroke=true,Visible=false,ZIndex=50,ClipsDescendants=true}); Utils.padding(list,4)
	Utils.create("UIListLayout",{Padding=UDim.new(0,2),Parent=list})
	local self=setmetatable({Runtime=runtime,Instance=holder,Selected=selected,List=list,Value=options.Default,Expanded=false},Dropdown)
	for _,item in ipairs(options.Items or {}) do self:addItem(item) end
	runtime:connect(button.Activated:Connect(function() self:toggle() end))
	return self
end
function Dropdown:addItem(item)
	local b=Utils.create("TextButton",{BackgroundColor3=self.Runtime.Theme.SurfaceAlt,BackgroundTransparency=1,BorderSizePixel=0,Size=UDim2.new(1,0,0,30),Text=tostring(item),TextColor3=self.Runtime.Theme.Text,TextSize=13,Font=self.Runtime.Options.Font,AutoButtonColor=false,Parent=self.List}); Utils.corner(b,7); self.Runtime:track(b)
	self.Runtime:connect(b.MouseEnter:Connect(function() self.Runtime:animate(b,{BackgroundTransparency=0},.1) end)); self.Runtime:connect(b.MouseLeave:Connect(function() self.Runtime:animate(b,{BackgroundTransparency=1},.1) end)); self.Runtime:connect(b.Activated:Connect(function() self:set(item); self:close() end))
	return self
end
function Dropdown:set(value) self.Value=value; self.Selected.Text=tostring(value); if self.OnChanged then self.OnChanged(value) end; return self end
function Dropdown:get() return self.Value end
function Dropdown:changed(callback) self.OnChanged=callback; return self end
function Dropdown:open() self.Expanded=true; self.List.Visible=true; local count=math.max(#self.List:GetChildren()-2,0); self.Runtime:animate(self.List,{Size=UDim2.new(1,0,0,math.min(count*32+8,190))}); return self end
function Dropdown:close() self.Expanded=false; self.List.Visible=false; return self end
function Dropdown:toggle() if self.Expanded then return self:close() else return self:open() end end
return Dropdown
