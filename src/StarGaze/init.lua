local Runtime = require(script.Core.Runtime)
local Themes = require(script.Core.Themes)
local Presets = require(script.Core.Presets)
local Settings = require(script.Core.Settings)
local Styles = require(script.Core.Styles)
local Templates = require(script.Core.Templates)

local StarGaze = {
	Version = "2.0.0",
	Themes = Themes,
	Presets = Presets,
	Settings = Settings,
	Styles = Styles,
	Templates = Templates,
}

function StarGaze.create(options)
	return Runtime.new(options)
end

return StarGaze
