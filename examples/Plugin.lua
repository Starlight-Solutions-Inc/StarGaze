local Plugin = {
	Name = "QuickActions",
}

function Plugin.Setup(context)
	local runtime = context.Runtime

	context.Actions = {
		Notify = function(text)
			runtime:notify({
				Title = "Quick Actions",
				Text = text,
				Type = "Info",
			})
		end,
	}
end

function Plugin.Destroy(context)
	context.Actions = nil
end

return Plugin
