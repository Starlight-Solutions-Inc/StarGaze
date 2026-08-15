local Utils = require(script.Parent.Parent.Core.Utils)
local UserInputService = game:GetService("UserInputService")

local Keybind = {}
Keybind.__index = Keybind

function Keybind.new(runtime, parent, options)
	options = options or {}
	local holder = runtime:card(parent, {Size = options.Size or UDim2.fromScale(1, 0.1), Color = options.Background or "Card", Radius = 10})
	runtime:createText(holder, options.Text or "Keybind", {Size = UDim2.fromScale(0.55, 1), Position = UDim2.fromScale(0.04, 0), TextSize = options.TextSize or 13})
	local button = Utils.create("TextButton", {BackgroundColor3 = runtime.Theme.SurfaceAlt, BorderSizePixel = 0, Size = UDim2.fromScale(0.28, 0.64), Position = UDim2.fromScale(0.66, 0.18), Text = options.Key and options.Key.Name or "Set Key", TextColor3 = runtime.Theme.Subtext, TextSize = 11, Font = runtime.Options.Font, AutoButtonColor = false, Parent = holder})
	Utils.corner(button, 8)
	runtime:track(holder); runtime:track(button)
	local self = setmetatable({Runtime = runtime, Instance = holder, Button = button, Key = options.Key, Listening = false}, Keybind)
	runtime:connect(button.Activated:Connect(function() self:capture() end))
	if options.Key and options.OnPressed then
		runtime:connect(UserInputService.InputBegan:Connect(function(input, processed)
			if not processed and input.KeyCode == self.Key then options.OnPressed(self, input) end
		end))
	end
	return self
end

function Keybind:capture()
	self.Listening = true
	self.Button.Text = "Press key..."
	return self
end

function Keybind:listen(callback)
	self.Runtime:connect(UserInputService.InputBegan:Connect(function(input, processed)
		if not self.Listening or processed then return end
		if input.KeyCode == Enum.KeyCode.Unknown then return end
		self.Key = input.KeyCode
		self.Button.Text = input.KeyCode.Name
		self.Listening = false
		if callback then callback(self.Key, self) end
	end))
	return self
end

function Keybind:set(key)
	self.Key = key
	self.Button.Text = key and key.Name or "Set Key"
	return self
end

function Keybind:get() return self.Key end
return Keybind
