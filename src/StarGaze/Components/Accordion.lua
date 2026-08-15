local Utils=require(script.Parent.Parent.Core.Utils)
local Accordion={};Accordion.__index=Accordion
function Accordion.new(runtime,parent,options)
	options=options or {}
	local root=runtime:card(parent,{Size=options.Size or UDim2.fromScale(1,0.12),Color=options.Color or "Card",Radius=options.Radius or 10,ClipsDescendants=true})
	local trigger=Utils.button(root)
	local title=runtime:createText(root,options.Title or "Section",{Size=UDim2.fromScale(0.8,0.45),Position=UDim2.fromScale(0.04,0.08),TextSize=options.TextSize or 13})
	local arrow=runtime:createText(root,"⌄",{Size=UDim2.fromScale(0.08,0.45),Position=UDim2.fromScale(0.88,0.08),TextSize=15,TextXAlignment=Enum.TextXAlignment.Center,Color="Subtext"})
	local body=runtime:createFrame(root,{Size=UDim2.fromScale(0.92,0.42),Position=UDim2.fromScale(0.04,0.52),Color=options.BodyColor or "SurfaceAlt",Radius=8,Visible=false})
	if options.Build then options.Build(body,runtime) end
	runtime:track(root);runtime:track(trigger)
	local self=setmetatable({Runtime=runtime,Instance=root,Body=body,Arrow=arrow,Open=false,OriginalWidth=root.Size.X.Scale,CollapsedHeight=0.12,ExpandedHeight=0.44},Accordion)
	runtime:connect(trigger.Activated:Connect(function() self:toggle() end))
	return self
end
function Accordion:open()
	self.Open = true
	self.Body.Visible = true
	self.Arrow.Text = "⌃"
	self.Runtime:animate(self.Instance, {Size = UDim2.fromScale(self.OriginalWidth, self.ExpandedHeight)}, 0.16)
	return self
end
function Accordion:close()
	self.Open = false
	self.Body.Visible = false
	self.Arrow.Text = "⌄"
	self.Runtime:animate(self.Instance, {Size = UDim2.fromScale(self.OriginalWidth, self.CollapsedHeight)}, 0.16)
	return self
end
function Accordion:toggle() if self.Open then return self:close() end return self:open() end
return Accordion
