local Utils=require(script.Parent.Parent.Core.Utils)
local CommandPalette={};CommandPalette.__index=CommandPalette
function CommandPalette.new(runtime,options)
	options=options or {}
	local overlay=Utils.create("Frame",{BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=0.45,BorderSizePixel=0,Size=UDim2.fromScale(1,1),Visible=false,ZIndex=900,Parent=runtime.Gui})
	local root=runtime:createFrame(overlay,{Size=options.Size or UDim2.fromScale(0.54,0.62),Position=UDim2.fromScale(0.5,0.19),AnchorPoint=Vector2.new(0.5,0),Color="Surface",Radius=14,Stroke=true,ZIndex=901,ClipsDescendants=true})
	local input=runtime:input(root,{Size=UDim2.fromScale(1,0.15),Placeholder=options.Placeholder or "Search commands...",Background="SurfaceAlt"})
	local results=runtime:createContainer(root,{Size=UDim2.fromScale(0.92,0.78),Position=UDim2.fromScale(0.04,0.18),Color="Surface",Layout={Padding=UDim.new(0,5)}})
	local self=setmetatable({Runtime=runtime,Overlay=overlay,Instance=root,Input=input,Results=results,Items=options.Items or {}},CommandPalette)
	self:refresh(options.Items or {})
	input:changed(function(value) self:filter(value) end)
	return self
end
function CommandPalette:refresh(items)
	for _,child in ipairs(self.Results:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
	for _,item in ipairs(items) do
		self.Runtime:button(self.Results,{Text=item.Text or item.Name or "Command",Size=UDim2.fromScale(1,0.12),Color="SurfaceAlt",OnClick=function() if item.OnClick then item.OnClick(item,self) end end})
	end
	return self
end
function CommandPalette:filter(query)
	query=string.lower(query or "")
	local filtered={}
	for _,item in ipairs(self.Items) do
		local text=string.lower(tostring(item.Text or item.Name or ""))
		if query=="" or string.find(text,query,1,true) then table.insert(filtered,item) end
	end
	return self:refresh(filtered)
end
function CommandPalette:open() self.Overlay.Visible=true;self.Input:focus();return self end
function CommandPalette:close() self.Overlay.Visible=false;return self end
function CommandPalette:toggle() if self.Overlay.Visible then return self:close() end return self:open() end
return CommandPalette
