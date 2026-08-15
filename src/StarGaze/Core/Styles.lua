local Utils = require(script.Parent.Utils)

local Styles = {}
Styles.__index = Styles

Styles.BuiltIn = {
	Soft = {
		Radius = 14,
		StrokeTransparency = 0.5,
		HoverStrength = 0.06,
		PressScale = 0.98,
		Shadow = false,
	},
		Sharp = {
		Radius = 5,
		StrokeTransparency = 0.2,
		HoverStrength = 0.04,
		PressScale = 0.985,
		Shadow = false,
	},
		Glass = {
		Radius = 16,
		Transparency = 0.18,
		StrokeTransparency = 0.28,
		HoverStrength = 0.05,
		PressScale = 0.985,
		Shadow = true,
	},
		Dense = {
		Radius = 8,
		StrokeTransparency = 0.36,
		HoverStrength = 0.04,
		PressScale = 0.985,
		Shadow = false,
	},
}

function Styles.new(runtime)
	return setmetatable({
		Runtime = runtime,
		Definitions = Utils.merge(Styles.BuiltIn),
	}, Styles)
end

function Styles:register(name, definition)
	self.Definitions[name] = Utils.merge(self.Definitions[name] or {}, definition or {})
	return self.Definitions[name]
end

function Styles:get(name)
	return self.Definitions[name]
end

function Styles:resolve(style)
	if type(style) == "string" then
		return self.Definitions[style] or self.Definitions.Soft
	end
	return style or self.Definitions.Soft
end

function Styles:apply(instance, style, overrides)
	local resolved = Utils.merge(self:resolve(style), overrides or {})
	if resolved.Radius ~= nil then
		local existing = instance:FindFirstChildOfClass("UICorner")
		if existing then
			existing.CornerRadius = UDim.new(0, resolved.Radius)
		else
			Utils.corner(instance, resolved.Radius)
		end
	end
	if resolved.Transparency ~= nil then
		instance.BackgroundTransparency = resolved.Transparency
	end
	return resolved
end

return Styles
