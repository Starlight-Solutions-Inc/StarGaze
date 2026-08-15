local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local Utils = require(script.Parent.Utils)
local Themes = require(script.Parent.Themes)
local Elements = require(script.Parent.Parent.Elements)
local Plugins = require(script.Parent.Plugins)
local Styles = require(script.Parent.Styles)
local Templates = require(script.Parent.Templates)
local Settings = require(script.Parent.Settings)

local Runtime = {}
Runtime.__index = Runtime

local Defaults = {
	Name = "StarGaze",
	Theme = "Obsidian",
	AnimationSpeed = 0.18,
	Font = Enum.Font.Gotham,
	DisplayOrder = 100,
}

function Runtime.new(options)
	options = Utils.merge(Defaults, options or {})
	local self = setmetatable({
		Options = options,
		Theme = Themes.resolve(options.Theme),
		Connections = {},
		Instances = {},
		ThemeListeners = {},
		Windows = {},
		Layers = {},
		Styles = nil,
		Templates = nil,
		Settings = nil,		
		Plugins = nil,
	}, Runtime)

	local parent = options.Parent or Players.LocalPlayer:WaitForChild("PlayerGui")

	self.Gui = Utils.create("ScreenGui", {
		Name = options.Name,
		ResetOnSpawn = false,
		IgnoreGuiInset = options.IgnoreGuiInset == true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = options.DisplayOrder,
		Parent = parent,
	})

	self:track(self.Gui)
	self.Settings = Settings.new(self, options.Settings)
	self.Options = Utils.merge(self.Options, self.Settings:all())
	self.Styles = Styles.new(self)
	self.Templates = Templates.new(self)
	self.Plugins = Plugins.new(self)
	self._elements = Elements.new(self)

	return self
end

function Runtime:track(instance)
	if instance then
		table.insert(self.Instances, instance)
	end
	return instance
end

function Runtime:connect(connection)
	if connection then
		table.insert(self.Connections, connection)
	end
	return connection
end

function Runtime:animate(instance, properties, duration, style, direction)
	local tween = TweenService:Create(instance, TweenInfo.new(
		duration or self.Options.AnimationSpeed,
		style or Enum.EasingStyle.Quart,
		direction or Enum.EasingDirection.Out
	), properties)
	tween:Play()
	return tween
end

function Runtime:onThemeChanged(callback)
	table.insert(self.ThemeListeners, callback)
	return callback
end

function Runtime:setTheme(theme)
	local nextTheme = Themes.resolve(theme)
	if not nextTheme then
		return false
	end
	self.Theme = nextTheme
	for _, callback in ipairs(self.ThemeListeners) do
		callback(nextTheme)
	end
	return true
end

function Runtime:registerLayer(name, instance)
	self.Layers[name] = instance
	return instance
end

function Runtime:getLayer(name)
	return self.Layers[name]
end


function Runtime:configure(values)
	self.Settings:update(values)
	self.Options = Utils.merge(self.Options, values or {})
	return self
end

function Runtime:setting(key, value)
	if value == nil then
		return self.Settings:get(key)
	end
	self.Settings:set(key, value)
	self.Options[key] = value
	return self
end

function Runtime:registerPlugin(plugin, options)
	return self.Plugins:register(plugin, options)
end

function Runtime:unregisterPlugin(name)
	return self.Plugins:unregister(name)
end

function Runtime:getPlugin(name)
	return self.Plugins:get(name)
end

function Runtime:listPlugins()
	return self.Plugins:list()
end

function Runtime:registerStyle(name, definition)
	return self.Styles:register(name, definition)
end

function Runtime:applyStyle(instance, style, overrides)
	return self.Styles:apply(instance, style, overrides)
end

function Runtime:registerTemplate(name, definition)
	return self.Templates:register(name, definition)
end

function Runtime:template(name, overrides)
	return self.Templates:resolve(name, overrides)
end

function Runtime:createFrame(parent, options)
	return self._elements:frame(parent, options)
end

function Runtime:createText(parent, text, options)
	return self._elements:text(parent, text, options)
end

function Runtime:createContainer(parent, options)
	return self._elements:container(parent, options)
end

function Runtime:button(parent, options)
	return require(script.Parent.Parent.Components.Button).new(self, parent, options)
end

function Runtime:toggle(parent, options)
	return require(script.Parent.Parent.Components.Toggle).new(self, parent, options)
end

function Runtime:checkbox(parent, options)
	return require(script.Parent.Parent.Components.Checkbox).new(self, parent, options)
end

function Runtime:radio(parent, options)
	return require(script.Parent.Parent.Components.Radio).new(self, parent, options)
end

function Runtime:slider(parent, options)
	return require(script.Parent.Parent.Components.Slider).new(self, parent, options)
end

function Runtime:dropdown(parent, options)
	return require(script.Parent.Parent.Components.Dropdown).new(self, parent, options)
end

function Runtime:segmented(parent, options)
	return require(script.Parent.Parent.Components.Segmented).new(self, parent, options)
end

function Runtime:accordion(parent, options)
	return require(script.Parent.Parent.Components.Accordion).new(self, parent, options)
end

function Runtime:colorPicker(parent, options)
	return require(script.Parent.Parent.Components.ColorPicker).new(self, parent, options)
end

function Runtime:keybind(parent, options)
	return require(script.Parent.Parent.Components.Keybind).new(self, parent, options)
end

function Runtime:responsive(root, options)
	return require(script.Parent.Responsive).apply(self, root, options)
end

function Runtime:input(parent, options)
	return require(script.Parent.Parent.Components.Input).new(self, parent, options)
end

function Runtime:progress(parent, options)
	return require(script.Parent.Parent.Components.Progress).new(self, parent, options)
end

function Runtime:tabs(parent, options)
	return require(script.Parent.Parent.Components.Tabs).new(self, parent, options)
end

function Runtime:window(options)
	return require(script.Parent.Parent.Components.Window).new(self, options)
end

function Runtime:notification(options)
	return require(script.Parent.Parent.Components.Notification).new(self, options)
end

function Runtime:notify(options)
	return self:notification(options)
end

function Runtime:confirm(options)
	return require(script.Parent.Parent.Components.Confirm).new(self, options)
end

function Runtime:contextMenu(options)
	return require(script.Parent.Parent.Components.ContextMenu).new(self, options)
end

function Runtime:commandPalette(options)
	return require(script.Parent.Parent.Components.CommandPalette).new(self, options)
end

function Runtime:badge(parent, options)
	return require(script.Parent.Parent.Components.Badge).new(self, parent, options)
end

function Runtime:divider(parent, options)
	return require(script.Parent.Parent.Components.Divider).new(self, parent, options)
end

function Runtime:tooltip(target, options)
	return require(script.Parent.Parent.Components.Tooltip).new(self, target, options)
end

function Runtime:card(parent, options)
	options = Utils.merge({Color = "Card", Radius = 12, Stroke = true, StrokeTransparency = 0.45}, options or {})
	return self:createFrame(parent, options)
end

function Runtime:glass(parent, options)
	options = Utils.merge({Color = "Glass", Transparency = 0.14, Radius = 14, Stroke = true, StrokeTransparency = 0.35}, options or {})
	return self:createFrame(parent, options)
end

function Runtime:destroy()
	for _, connection in ipairs(self.Connections) do
		connection:Disconnect()
	end
	for _, instance in ipairs(self.Instances) do
		if instance and instance.Parent then
			instance:Destroy()
		end
	end
	self.Connections = {}
	self.Instances = {}
	self.Windows = {}
	self.Layers = {}
	self.Gui = nil
end

return Runtime
