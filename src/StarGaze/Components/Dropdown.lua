local Utils=require(script.Parent.Parent.Core.Utils)
local Dropdown={};Dropdown.__index=Dropdown
function Dropdown.new(runtime,parent,options)
	options=options or {}
	local holder=runtime:card(parent,{Size=options.Size or UDim2.fromScale(1,0.12),Color=options.Background or "Card",Radius=options.Radius or 10,ClipsDescendants=false,ZIndex=options.ZIndex or 20})
	runtime:createText(holder,options.Text or "Select",{Size=UDim2.fromScale(0.36,1),Position=UDim2.fromScale(0.04,0),TextSize=options.TextSize or 13})
	local selected=runtime:createText(holder,tostring(options.Default or "Choose..."),{Size=UDim2.fromScale(0.42,1),Position=UDim2.fromScale(0.49,0),TextSize=12,TextXAlignment=Enum.TextXAlignment.Right,Color="Subtext"})
	local arrow=runtime:createText(holder,"⌄",{Size=UDim2.fromScale(0.08,1),Position=UDim2.fromScale(0.87,0),TextSize=16,TextXAlignment=Enum.TextXAlignment.Center,Color="Subtext"})
	local trigger=Utils.button(holder)
	local list=runtime:createFrame(holder,{Size=UDim2.fromScale(1,0),Position=UDim2.fromScale(0,1.08),Color="Surface",Radius=10,Stroke=true,Visible=false,ZIndex=(options.ZIndex or 20)+10,ClipsDescendants=true})
	Utils.padding(list,5,5,5,5)
	Utils.list(list,{Padding=UDim.new(0,4)})
	runtime:track(holder);runtime:track(trigger);runtime:track(list)
	local self=setmetatable({Runtime=runtime,Instance=holder,List=list,Selected=selected,Arrow=arrow,Value=options.Default,Expanded=false},Dropdown)
	for _,item in ipairs(options.Items or {}) do self:add(item) end
	runtime:connect(trigger.Activated:Connect(function() self:toggle() end))
	return self
end
function Dropdown:add(item)
	local button=Utils.create("TextButton",{BackgroundColor3=self.Runtime.Theme.SurfaceAlt,BackgroundTransparency=1,BorderSizePixel=0,Size=UDim2.fromScale(1,0.16),Text=tostring(item),TextColor3=self.Runtime.Theme.Text,TextSize=12,Font=self.Runtime.Options.Font,AutoButtonColor=false,Parent=self.List})
	Utils.corner(button,8);self.Runtime:track(button)
	self.Runtime:connect(button.MouseEnter:Connect(function() self.Runtime:animate(button,{BackgroundTransparency=0},0.1) end))
	self.Runtime:connect(button.MouseLeave:Connect(function() self.Runtime:animate(button,{BackgroundTransparency=1},0.1) end))
	self.Runtime:connect(button.Activated:Connect(function() self:set(item);self:close() end))
	return self
end
function Dropdown:open()
	self.Expanded=true;self.List.Visible=true;self.Arrow.Text="⌃"
	local count=0
	for _,child in ipairs(self.List:GetChildren()) do if child:IsA("TextButton") then count+=1 end end
	self.Runtime:animate(self.List,{Size=UDim2.fromScale(1,math.clamp(count*0.17+0.04,0.08,0.9))},0.15)
	return self
end
function Dropdown:close() self.Expanded=false;self.List.Visible=false;self.Arrow.Text="⌄";return self end
function Dropdown:toggle() if self.Expanded then return self:close() end return self:open() end
function Dropdown:set(value) self.Value=value;self.Selected.Text=tostring(value);if self.OnChanged then self.OnChanged(value,self) end;return self end
function Dropdown:get() return self.Value end
function Dropdown:changed(callback) self.OnChanged=callback return self end
return Dropdown
