local Utils = require(script.Parent.Utils)

local Settings = {}
Settings.__index = Settings

Settings.Defaults = {
	Density = "Comfortable",
	Style = "Soft",
	Template = "Dashboard",
	CornerRadius = 10,
	Animation = true,
	AnimationSpeed = 0.18,
	Hover = true,
	Press = true,
	FocusRing = true,
	Tooltips = true,
	Glassmorphism = false,
	Shadows = false,
	Outline = true,
	OutlineTransparency = 0.35,
	ModalOpacity = 0.4,
	NotificationDuration = 4,
	NotificationPosition = "TopRight",
	Responsive = true,
	ScaleMin = 0.78,
	ScaleMax = 1.08,
	Font = Enum.Font.Gotham,
	TextScale = 1,
	IconStyle = "Solid",
	IconSize = 18,
	SidebarWidth = 0.18,
	SectionSpacing = 0.014,
	ComponentSpacing = 0.012,
	PagePadding = 0.022,
}

function Settings.new(runtime, initial)
	return setmetatable({
		Runtime = runtime,
		Values = Utils.merge(Settings.Defaults, initial or {}),
		Listeners = {},
	}, Settings)
end

function Settings:get(key, fallback)
	local value = self.Values[key]
	if value == nil then
		return fallback
	end
	return value
end

function Settings:set(key, value)
	self.Values[key] = value
	local listeners = self.Listeners[key]
	if listeners then
		for _, callback in ipairs(listeners) do
			callback(value)
		end
	end
	return self
end

function Settings:update(values)
	for key, value in pairs(values or {}) do
		self:set(key, value)
	end
	return self
end

function Settings:changed(key, callback)
	self.Listeners[key] = self.Listeners[key] or {}
	table.insert(self.Listeners[key], callback)
	return self
end

function Settings:all()
	return Utils.merge({}, self.Values)
end

return Settings
