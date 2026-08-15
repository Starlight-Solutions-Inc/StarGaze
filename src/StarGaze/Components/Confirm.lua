local Utils=require(script.Parent.Parent.Utils)
local Confirm={}; Confirm.__index=Confirm
function Confirm.new(runtime,options)
	options=options or {}; local overlay=Utils.create("TextButton",{BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=.4,BorderSizePixel=0,Size=UDim2.fromScale(1,1),Text="",AutoButtonColor=false,ZIndex=200,Parent=runtime.Gui})
	local dialog=runtime:createFrame(overlay,{Size=options.Size or UDim2.fromOffset(390,190),Position=UDim2.fromScale(.5,.5),AnchorPoint=Vector2.new(.5,.5),Color=options.Color or "Surface",CornerRadius=14,Stroke=true,StrokeColor="Border",ZIndex=201})
	runtime:createText(dialog,options.Title or "Confirm Action",{Size=UDim2.new(1,-32,0,30),Position=UDim2.fromOffset(16,16),TextSize=17})
	runtime:createText(dialog,options.Text or "Are you sure?",{Size=UDim2.new(1,-32,0,64),Position=UDim2.fromOffset(16,52),TextSize=13,TextWrapped=true,Color="Subtext",TextYAlignment=Enum.TextYAlignment.Top})
	local self=setmetatable({Runtime=runtime,Instance=overlay},Confirm)
	runtime:button(dialog,{Text=options.CancelText or "Cancel",Color="SurfaceAlt",Size=UDim2.fromOffset(110,38),Position=UDim2.new(1,-244,1,-54),OnClick=function() if options.OnCancel then options.OnCancel() end self:close() end})
	runtime:button(dialog,{Text=options.ConfirmText or "Confirm",Color=options.ConfirmColor or "Accent",Size=UDim2.fromOffset(110,38),Position=UDim2.new(1,-124,1,-54),OnClick=function() if options.OnConfirm then options.OnConfirm() end self:close() end})
	runtime:track(overlay); return self
end
function Confirm:close() if self.Instance.Parent then self.Instance:Destroy() end end
return Confirm
