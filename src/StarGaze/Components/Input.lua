local Utils = require(script.Parent.Parent.Core.Utils)

local Input = {}
Input.__index = Input

function Input.new(runtime,parent,options)
	options=options or {}
	local holder=runtime:card(parent,{Size=options.Size or UDim2.fromScale(1,0.12),Color=options.Background or "Card",Radius=options.Radius or 10})
	if options.Label then runtime:createText(holder,options.Label,{Size=UDim2.fromScale(0.23,1),Position=UDim2.fromScale(0.04,0),TextSize=options.LabelSize or 13}) end
	local box=Utils.create("Frame",{BackgroundColor3=runtime.Theme.SurfaceAlt,BorderSizePixel=0,Size=options.Label and UDim2.fromScale(0.67,0.66) or UDim2.fromScale(0.92,0.66),Position=options.Label and UDim2.fromScale(0.29,0.17) or UDim2.fromScale(0.04,0.17),Parent=holder})
	Utils.corner(box,8)
	Utils.stroke(box,runtime.Theme.BorderSoft,0.25)
	local field=Utils.create("TextBox",{BackgroundTransparency=1,BorderSizePixel=0,ClearTextOnFocus=false,Size=UDim2.fromScale(0.94,1),Position=UDim2.fromScale(0.03,0),Text=options.Default or "",PlaceholderText=options.Placeholder or "Type here...",TextColor3=runtime.Theme.Text,PlaceholderColor3=runtime.Theme.Muted,TextSize=options.TextSize or 13,Font=runtime.Options.Font,TextXAlignment=Enum.TextXAlignment.Left,Parent=box})
	if options.MultiLine then field.MultiLine=true end
	runtime:track(holder);runtime:track(box);runtime:track(field)
	local self=setmetatable({Runtime=runtime,Instance=holder,Field=field},Input)
	runtime:connect(field.FocusLost:Connect(function(enter) if self.OnFocusLost then self.OnFocusLost(field.Text,enter,self) end end))
	return self
end
function Input:get() return self.Field.Text end
function Input:set(value) self.Field.Text=tostring(value) return self end
function Input:changed(callback) self.OnChanged=callback;self.Runtime:connect(self.Field:GetPropertyChangedSignal("Text"):Connect(function() callback(self.Field.Text,self) end));return self end
function Input:focus() self.Field:CaptureFocus();return self end
function Input:focusLost(callback) self.OnFocusLost=callback return self end
return Input
