local Utils=require(script.Parent.Parent.Core.Utils)
local ContextMenu={};ContextMenu.__index=ContextMenu
function ContextMenu.new(runtime,options)
	options=options or {}
	local menu=runtime:createFrame(runtime.Gui,{Size=options.Size or UDim2.fromScale(0.22,0.28),Color=options.Color or "Surface",Radius=10,Stroke=true,Visible=false,ZIndex=800,Position=options.Position or UDim2.fromScale(0.5,0.5),AnchorPoint=Vector2.new(0,0)})
	Utils.padding(menu,5,5,5,5);Utils.list(menu,{Padding=UDim.new(0,4)})
	local self=setmetatable({Runtime=runtime,Instance=menu},ContextMenu)
	for _,item in ipairs(options.Items or {}) do self:add(item) end
	return self
end
function ContextMenu:add(item)
	local button=self.Runtime:button(self.Instance,{Text=item.Text or item.Name or "Action",Color="SurfaceAlt",Size=UDim2.fromScale(1,0.15),OnClick=function() if item.OnClick then item.OnClick(self) end self:close() end})
	return button
end
function ContextMenu:open(position)
	if position then self.Instance.Position=position end
	self.Instance.Visible=true;return self
end
function ContextMenu:close() self.Instance.Visible=false;return self end
function ContextMenu:toggle(position) if self.Instance.Visible then return self:close() end return self:open(position) end
return ContextMenu
