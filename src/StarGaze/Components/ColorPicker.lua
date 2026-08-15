local Utils=require(script.Parent.Parent.Core.Utils)
local ColorPicker={};ColorPicker.__index=ColorPicker
function ColorPicker.new(runtime,parent,options)
	options=options or {}
	local holder=runtime:card(parent,{Size=options.Size or UDim2.fromScale(1,0.11),Color=options.Background or "Card",Radius=10})
	runtime:createText(holder,options.Text or "Color",{Size=UDim2.fromScale(0.62,1),Position=UDim2.fromScale(0.04,0),TextSize=13})
	local swatch=Utils.create("TextButton",{BackgroundColor3=options.Default or runtime.Theme.Accent,BorderSizePixel=0,Size=UDim2.fromScale(0.12,0.58),Position=UDim2.fromScale(0.82,0.21),Text="",AutoButtonColor=false,Parent=holder})
	Utils.corner(swatch,8);Utils.stroke(swatch,runtime.Theme.Border,0.2)
	local expanded=false
	local panel=runtime:createFrame(holder,{Size=UDim2.fromScale(0.94,2.2),Position=UDim2.fromScale(0.03,1.04),Color="Surface",Radius=10,Stroke=true,Visible=false,ZIndex=80})
	Utils.padding(panel,8,8,8,8);Utils.list(panel,{Padding=UDim.new(0,7)})
	local values=options.Colors or {runtime.Theme.Accent,runtime.Theme.AccentHover,runtime.Theme.Success,runtime.Theme.Warning,runtime.Theme.Danger,runtime.Theme.Info,runtime.Theme.Text}
	local self=setmetatable({Runtime=runtime,Instance=holder,Swatch=swatch,Panel=panel,Value=options.Default or values[1]},ColorPicker)
	for _,color in ipairs(values) do
		local choice=Utils.create("TextButton",{BackgroundColor3=color,BorderSizePixel=0,Size=UDim2.fromScale(1,0.11),Text="",AutoButtonColor=false,Parent=panel})
		Utils.corner(choice,8);runtime:track(choice)
		runtime:connect(choice.Activated:Connect(function() self:set(color);self:close() end))
	end
	runtime:track(holder);runtime:track(swatch);runtime:track(panel)
	runtime:connect(swatch.Activated:Connect(function() if expanded then self:close() else self:open() end end))
	return self
end
function ColorPicker:set(color) self.Value=color;self.Swatch.BackgroundColor3=color;if self.OnChanged then self.OnChanged(color,self) end;return self end
function ColorPicker:get() return self.Value end
function ColorPicker:changed(callback) self.OnChanged=callback return self end
function ColorPicker:open() self.Panel.Visible=true;self.Panel.Size=UDim2.fromScale(0.94,2.2);self.Open=true;return self end
function ColorPicker:close() self.Panel.Visible=false;self.Open=false;return self end
return ColorPicker
