local Runtime = require(script.Runtime)
local Themes = require(script.Themes)
local Presets = require(script.Presets)

local StarGaze = {}
StarGaze.__index = StarGaze
StarGaze.Version = "1.0.0"
StarGaze.Author = "Starlight Solutions, Inc."
StarGaze.Themes = Themes
StarGaze.Presets = Presets

function StarGaze.new(options)
	return Runtime.new(options)
end

return StarGaze
