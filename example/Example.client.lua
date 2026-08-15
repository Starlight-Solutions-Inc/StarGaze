local StarGaze = require(game.ReplicatedStorage.StarGaze)

local UI = StarGaze.new({Name="StarGazeExample", Theme="Obsidian"})

local window = UI:window({
	Name="Main",
	Title="StarGaze",
	Subtitle="Starlight Solutions, Inc.",
	Size=UDim2.fromOffset(700,470),
	Position=UDim2.fromScale(.5,.5),
})

local content = UI:createContainer(window.Content, {
	Size=UDim2.new(1,-24,1,-24),
	Position=UDim2.fromOffset(12,12),
	Color="Background",
	Layout={Padding=UDim.new(0,8)},
})

UI:createText(content,"Interface Controls",{Size=UDim2.new(1,0,0,26),TextSize=17})
UI:createText(content,"A modular demonstration of the StarGaze component system.",{Size=UDim2.new(1,0,0,22),TextSize=12,Color="Subtext"})
UI:divider(content)

UI:toggle(content,{Text="Enable animated effects",Default=true}):changed(function(value)
	UI:notify({Title="Effects",Text=value and "Animations enabled." or "Animations disabled.",Type="Info"})
end)

UI:slider(content,{Text="Interface Scale",Min=75,Max=125,Default=100})

UI:dropdown(content,{Text="Theme",Items={"Obsidian","Midnight","Carbon","Violet"},Default="Obsidian"}):changed(function(value)
	UI:setTheme(value)
end)

UI:button(content,{Text="Show Notification",Color="Accent",Size=UDim2.new(1,0,0,42),OnClick=function()
	UI:notify({Title="StarGaze",Text="The interface is working.",Type="Success"})
end})

UI:button(content,{Text="Open Confirmation",Color="SurfaceAlt",Size=UDim2.new(1,0,0,42),OnClick=function()
	UI:confirm({Title="Continue?",Text="This demonstrates StarGaze's modal confirmation component.",OnConfirm=function()
		UI:notify({Title="Confirmed",Text="The action was accepted.",Type="Success"})
	end})
end})

window:open()
