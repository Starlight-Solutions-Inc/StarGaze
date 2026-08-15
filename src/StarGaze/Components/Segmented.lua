local Utils = require(script.Parent.Parent.Core.Utils)
local Segmented = {}
Segmented.__index = Segmented
function Segmented.new(runtime,parent,options)
	options=options or {}
	local root=runtime:card(parent,{Size=options.Size or UDim2.fromScale(1,0.1),Color=options.Background or "SurfaceAlt",Radius=options.Radius or 10})
	Utils.padding(root,4,4,4,4);Utils.list(root,{Direction=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,Padding=UDim.new(0,4),Wraps=true})
	local self=setmetatable({Runtime=runtime,Instance=root,Items={},Value=options.Default},Segmented)
	for _,item in ipairs(options.Items or {}) do self:add(item) end
	if self.Value then self:select(self.Value) elseif options.Items and options.Items[1] then self:select(options.Items[1].Value or options.Items[1].Name or options.Items[1]) end
	return self
end
function Segmented:add(item)
	local name=item.Value or item.Name or item
	local text=item.Text or item.Name or tostring(name)
	local button=Utils.create("TextButton",{BackgroundColor3=self.Runtime.Theme.SurfaceAlt,BackgroundTransparency=1,BorderSizePixel=0,Size=item.Size or UDim2.fromScale(0.2,0.8),Text=text,TextColor3=self.Runtime.Theme.Text,TextSize=item.TextSize or 12,Font=self.Runtime.Options.Font,AutoButtonColor=false,Parent=self.Instance})
	Utils.corner(button,7);self.Runtime:track(button);self.Items[name]={Button=button,Definition=item}
	self.Runtime:connect(button.Activated:Connect(function() self:select(name) end))
	return self
end
function Segmented:select(name)
	local entry=self.Items[name];if not entry then return self end
	for key,item in pairs(self.Items) do
		local active=key==name
		self.Runtime:animate(item.Button,{BackgroundColor3=active and self.Runtime.Theme.Accent or self.Runtime.Theme.SurfaceAlt,BackgroundTransparency=active and 0 or 1},0.12)
	end
	self.Value=name
	if entry.Definition.OnSelected then entry.Definition.OnSelected(name,self) end
	if self.OnChanged then self.OnChanged(name,self) end
	return self
end
function Segmented:changed(callback) self.OnChanged=callback return self end
function Segmented:get() return self.Value end
return Segmented
