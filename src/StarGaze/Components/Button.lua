local Utils = require(script.Parent.Parent.Utils)
local Button = {}
Button.__index = Button
function Button.new(runtime, parent, options)
	options=options or {}
	local instance=Utils.create("TextButton",{Name=options.Name or "Button",AutoButtonColor=false,BackgroundColor3=Utils.resolveColor(options.Color or "Accent",runtime.Theme),BackgroundTransparency=options.Transparency or 0,BorderSizePixel=0,Size=options.Size or UDim2.fromOffset(160,42),Position=options.Position or UDim2.fromOffset(0,0),AnchorPoint=options.AnchorPoint or Vector2.zero,Text="",ClipsDescendants=true,ZIndex=options.ZIndex or 1,Parent=parent or runtime.Gui})
	Utils.corner(instance,options.CornerRadius or 9)
	if options.Stroke then Utils.stroke(instance,Utils.resolveColor(options.StrokeColor or "Border",runtime.Theme),options.StrokeTransparency or 0) end
	local text=runtime:createText(instance,options.Text or "Button",{Size=UDim2.new(1,-24,1,0),Position=UDim2.fromOffset(12,0),Color=options.TextColor or "Text",TextSize=options.TextSize or 14,Font=options.Font or runtime.Options.Font,TextXAlignment=options.TextXAlignment or Enum.TextXAlignment.Center})
	runtime:track(instance)
	Utils.bindHover(runtime,instance,options); Utils.bindPress(runtime,instance,options)
	local self=setmetatable({Runtime=runtime,Instance=instance,Text=text},Button)
	if options.OnClick then self:connect(options.OnClick) end
	return self
end
function Button:connect(callback) return self.Runtime:connect(self.Instance.Activated:Connect(function() callback(self) end)) end
function Button:setText(value) self.Text.Text=tostring(value); return self end
function Button:setColor(value) self.Runtime:animate(self.Instance,{BackgroundColor3=Utils.resolveColor(value,self.Runtime.Theme)}); return self end
function Button:setVisible(value) self.Instance.Visible=value==true; return self end
function Button:destroy() self.Instance:Destroy() end
return Button
