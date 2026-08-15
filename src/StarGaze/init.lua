local Runtime = require(script.Core.Runtime)
local Themes = require(script.Core.Themes)
local Presets = require(script.Core.Presets)

local StarGaze = {
	Version = "2.0.0",
	Themes = Themes,
	Presets = Presets,
}

function StarGaze.create(options)
	return Runtime.new(options)
end

return StarGaze
