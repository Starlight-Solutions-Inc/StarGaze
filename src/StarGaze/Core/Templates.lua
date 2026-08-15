local Utils = require(script.Parent.Utils)

local Templates = {}
Templates.__index = Templates

Templates.BuiltIn = {
	MinimalWindow = {
		Window = {
			Size = UDim2.fromScale(0.56, 0.68),
			CornerRadius = 12,
			Stroke = true,
		},
		Content = {
			Padding = 0.025,
		},
	},
	Dashboard = {
		Window = {
			Size = UDim2.fromScale(0.72, 0.78),
			CornerRadius = 16,
			Stroke = true,
		},
		Content = {
			Padding = 0.022,
		},
	},
	CompactPanel = {
		Window = {
			Size = UDim2.fromScale(0.42, 0.64),
			CornerRadius = 9,
			Stroke = true,
		},
		Content = {
			Padding = 0.018,
		},
	},
	Inspector = {
		Window = {
			Size = UDim2.fromScale(0.34, 0.82),
			CornerRadius = 10,
			Stroke = true,
		},
		Content = {
			Padding = 0.016,
		},
	},
}

function Templates.new(runtime)
	return setmetatable({
		Runtime = runtime,
		Definitions = Utils.merge(Templates.BuiltIn),
	}, Templates)
end

function Templates:register(name, definition)
	self.Definitions[name] = Utils.merge(self.Definitions[name] or {}, definition or {})
	return self.Definitions[name]
end

function Templates:get(name)
	return self.Definitions[name]
end

function Templates:resolve(name, overrides)
	return Utils.merge(self.Definitions[name] or {}, overrides or {})
end

return Templates
