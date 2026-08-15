local Utils=require(script.Parent.Parent.Core.Utils)
local Confirm={};Confirm.__index=Confirm
function Confirm.new(runtime,options)
	options=options or {}
	local overlay=Utils.create("Frame",{BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=0.42,BorderSizePixel=0,Size=UDim2.fromScale(1,1),ZIndex=700,Parent=runtime.Gui})
	local dialog=runtime:createFrame(overlay,{Size=options.Size or UDim2.fromScale(0.42,0.33),Position=UDim2.fromScale(0.5,0.5),AnchorPoint=Vector2.new(0.5,0.5),Color=options.Color or "Surface",Radius=14,Stroke=true,ZIndex=701})
	runtime:createText(dialog,options.Title or "Confirm Action",{Size=UDim2.fromScale(0.9,0.2),Position=UDim2.fromScale(0.05,0.08),TextSize=17})
	runtime:createText(dialog,options.Text or "Are you sure?",{Size=UDim2.fromScale(0.9,0.34),Position=UDim2.fromScale(0.05,0.3),TextSize=12,Color="Subtext",TextWrapped=true,TextYAlignment=Enum.TextYAlignment.Top})
	local self=setmetatable({Runtime=runtime,Instance=overlay},Confirm)
	runtime:button(dialog,{Text=options.CancelText or "Cancel",Color="SurfaceAlt",Size=UDim2.fromScale(0.27,0.2),Position=UDim2.fromScale(0.41,0.72),OnClick=function() if options.OnCancel then options.OnCancel() end self:close() end})
	runtime:button(dialog,{Text=options.ConfirmText or "Confirm",Color=options.ConfirmColor or "Accent",Size=UDim2.fromScale(0.27,0.2),Position=UDim2.fromScale(0.71,0.72),OnClick=function() if options.OnConfirm then options.OnConfirm() end self:close() end})
	runtime:track(overlay)
	return self
end
function Confirm:close() if self.Instance.Parent then self.Instance:Destroy() end end
return Confirm
