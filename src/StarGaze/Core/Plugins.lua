\
local Utils = require(script.Parent.Utils)

local Plugins = {}
Plugins.__index = Plugins

function Plugins.new(runtime)
	return setmetatable({
		Runtime = runtime,
		Loaded = {},
		Order = {},
	}, Plugins)
end

function Plugins:register(plugin, options)
	assert(type(plugin) == "table", "StarGaze plugin must be a table")
	assert(type(plugin.Name) == "string" and plugin.Name ~= "", "StarGaze plugin needs a Name")

	if self.Loaded[plugin.Name] then
		self:unregister(plugin.Name)
	end

	local context = {
		Runtime = self.Runtime,
		Options = Utils.merge({}, options or {}),
	}

	self.Loaded[plugin.Name] = {
		Definition = plugin,
		Context = context,
	}
	table.insert(self.Order, plugin.Name)

	if type(plugin.Setup) == "function" then
		plugin.Setup(context)
	end

	return context
end

function Plugins:unregister(name)
	local entry = self.Loaded[name]
	if not entry then
		return false
	end

	if type(entry.Definition.Destroy) == "function" then
		entry.Definition.Destroy(entry.Context)
	end

	self.Loaded[name] = nil
	for index, pluginName in ipairs(self.Order) do
		if pluginName == name then
			table.remove(self.Order, index)
			break
		end
	end

	return true
end

function Plugins:get(name)
	local entry = self.Loaded[name]
	return entry and entry.Context or nil
end

function Plugins:list()
	local result = {}
	for _, name in ipairs(self.Order) do
		table.insert(result, name)
	end
	return result
end

return Plugins
