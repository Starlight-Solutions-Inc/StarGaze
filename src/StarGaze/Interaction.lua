local Utils = require(script.Parent.Utils)

local Interaction = {}

function Interaction.bind(runtime, button, options)
	Utils.bindHover(runtime, button, options or {})
	Utils.bindPress(runtime, button, options or {})
end

return Interaction
