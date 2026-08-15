local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Utils = require(script.Parent.Utils)
local Themes = require(script.Parent.Themes)
local Elements = require(script.Parent.Elements)
local Runtime = {}
Runtime.__index = Runtime

local Defaults = {Name="StarGaze", Theme="Obsidian", DisplayOrder=100, AnimationSpeed=0.18, Font=Enum.Font.Gotham}

function Runtime.new(options)
	options = Utils.merge(Defaults, options or {})
	local self = setmetatable({Options=options, Theme=Themes.resolve(options.Theme), Connections={}, Instances={}, Components={}, Windows={}, ThemeListeners={}}, Runtime)
	local parent = options.Parent or Players.LocalPlayer:WaitForChild("PlayerGui")
	self.Gui = Utils.create("ScreenGui", {Name=options.Name, ResetOnSpawn=false, ZIndexBehavior=Enum.ZIndexBehavior.Sibling, IgnoreGuiInset=options.IgnoreGuiInset==true, DisplayOrder=options.DisplayOrder, Parent=parent})
	self:track(self.Gui)
	self._elements = Elements.new(self)
	return self
end

function Runtime:track(instance) table.insert(self.Instances, instance); return instance end
function Runtime:connect(connection) table.insert(self.Connections, connection); return connection end
function Runtime:animate(instance, properties, duration, style, direction)
	local tween = TweenService:Create(instance, TweenInfo.new(duration or self.Options.AnimationSpeed, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out), properties)
	tween:Play()
	return tween
end
function Runtime:setTheme(theme)
	local resolved = Themes.resolve(theme)
	if not resolved then return false end
	self.Theme = resolved
	for _, callback in ipairs(self.ThemeListeners) do callback(resolved) end
	return true
end
function Runtime:onThemeChanged(callback) table.insert(self.ThemeListeners, callback); return callback end
function Runtime:createFrame(parent, options) return self._elements:frame(parent, options) end
function Runtime:createText(parent, text, options) return self._elements:text(parent, text, options) end
function Runtime:createContainer(parent, options) return self._elements:container(parent, options) end
function Runtime:card(parent, options) return self:createFrame(parent, Utils.merge({Color="Card", CornerRadius=12, Stroke=true, StrokeTransparency=0.35}, options or {})) end
function Runtime:glass(parent, options) return self:createFrame(parent, Utils.merge({Color="Glass", Transparency=0.18, CornerRadius=14, Stroke=true, StrokeTransparency=0.25}, options or {})) end
function Runtime:button(parent, options) return require(script.Parent.Components.Button).new(self, parent, options) end
function Runtime:toggle(parent, options) return require(script.Parent.Components.Toggle).new(self, parent, options) end
function Runtime:slider(parent, options) return require(script.Parent.Components.Slider).new(self, parent, options) end
function Runtime:dropdown(parent, options) return require(script.Parent.Components.Dropdown).new(self, parent, options) end
function Runtime:tabs(parent, options) return require(script.Parent.Components.Tabs).new(self, parent, options) end
function Runtime:window(options) return require(script.Parent.Components.Window).new(self, options) end
function Runtime:notify(options) return require(script.Parent.Components.Notification).new(self, options) end
function Runtime:confirm(options) return require(script.Parent.Components.Confirm).new(self, options) end
function Runtime:badge(parent, options) return require(script.Parent.Components.Badge).new(self, parent, options) end
function Runtime:divider(parent, options) return require(script.Parent.Components.Divider).new(self, parent, options) end
function Runtime:tooltip(target, options) return require(script.Parent.Components.Tooltip).new(self, target, options) end
function Runtime:pulse(instance, strength, duration)
	local scale = instance:FindFirstChildOfClass("UIScale") or Utils.create("UIScale", {Scale=1, Parent=instance})
	self:animate(scale, {Scale=strength or 1.04}, duration or .1).Completed:Connect(function() self:animate(scale, {Scale=1}, duration or .1) end)
end
function Runtime:destroy()
	for _, connection in ipairs(self.Connections) do connection:Disconnect() end
	for _, instance in ipairs(self.Instances) do if instance and instance.Parent then instance:Destroy() end end
	self.Connections={}; self.Instances={}; self.Components={}; self.Windows={}; self.Gui=nil
end
return Runtime
