local Utils = require(script.Parent.Utils)

local Responsive = {}

function Responsive.apply(runtime, root, options)
	options = options or {}
	local uiScale = Utils.scale(root, options.Scale or 1)
	local camera = workspace.CurrentCamera
	local connection

	local function update()
		if not camera then return end
		local width = camera.ViewportSize.X
		local height = camera.ViewportSize.Y
		local base = options.BaseWidth or 1440
		local scale = math.clamp(width / base, options.Min or 0.75, options.Max or 1.15)
		if height < (options.SmallHeight or 700) then
			scale *= options.SmallMultiplier or 0.94
		end
		runtime:animate(uiScale, {Scale = scale}, 0.16)
	end

	connection = runtime:connect(camera:GetPropertyChangedSignal("ViewportSize"):Connect(update))
	update()

	return uiScale, connection
end

return Responsive
