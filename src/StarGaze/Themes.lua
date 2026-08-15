local Themes = {}

Themes.Definitions = {
	Obsidian = {
		Background = Color3.fromRGB(10, 10, 13), Surface = Color3.fromRGB(19, 19, 24), SurfaceAlt = Color3.fromRGB(25, 25, 32), Glass = Color3.fromRGB(25, 25, 31), Card = Color3.fromRGB(22, 22, 28), Border = Color3.fromRGB(55, 55, 68), Text = Color3.fromRGB(244, 244, 248), Subtext = Color3.fromRGB(158, 158, 172), Accent = Color3.fromRGB(142, 92, 255), AccentAlt = Color3.fromRGB(179, 138, 255), Success = Color3.fromRGB(74, 210, 130), Warning = Color3.fromRGB(246, 183, 67), Danger = Color3.fromRGB(242, 82, 82), Info = Color3.fromRGB(81, 157, 255),
	},
	Midnight = {
		Background = Color3.fromRGB(7, 12, 22), Surface = Color3.fromRGB(13, 20, 34), SurfaceAlt = Color3.fromRGB(18, 28, 45), Glass = Color3.fromRGB(19, 29, 46), Card = Color3.fromRGB(15, 24, 39), Border = Color3.fromRGB(45, 65, 92), Text = Color3.fromRGB(239, 244, 255), Subtext = Color3.fromRGB(145, 159, 181), Accent = Color3.fromRGB(77, 143, 255), AccentAlt = Color3.fromRGB(122, 175, 255), Success = Color3.fromRGB(73, 216, 143), Warning = Color3.fromRGB(246, 184, 72), Danger = Color3.fromRGB(239, 81, 95), Info = Color3.fromRGB(75, 171, 255),
	},
	Carbon = {
		Background = Color3.fromRGB(4, 5, 6), Surface = Color3.fromRGB(12, 13, 15), SurfaceAlt = Color3.fromRGB(18, 19, 22), Glass = Color3.fromRGB(18, 19, 22), Card = Color3.fromRGB(14, 15, 17), Border = Color3.fromRGB(42, 44, 48), Text = Color3.fromRGB(246, 246, 246), Subtext = Color3.fromRGB(148, 150, 155), Accent = Color3.fromRGB(232, 232, 238), AccentAlt = Color3.fromRGB(255, 255, 255), Success = Color3.fromRGB(81, 213, 130), Warning = Color3.fromRGB(245, 184, 63), Danger = Color3.fromRGB(241, 84, 84), Info = Color3.fromRGB(94, 157, 255),
	},
	Violet = {
		Background = Color3.fromRGB(12, 7, 18), Surface = Color3.fromRGB(24, 14, 34), SurfaceAlt = Color3.fromRGB(32, 19, 44), Glass = Color3.fromRGB(31, 18, 43), Card = Color3.fromRGB(26, 15, 37), Border = Color3.fromRGB(71, 42, 90), Text = Color3.fromRGB(249, 244, 255), Subtext = Color3.fromRGB(166, 145, 179), Accent = Color3.fromRGB(176, 89, 255), AccentAlt = Color3.fromRGB(207, 145, 255), Success = Color3.fromRGB(76, 215, 137), Warning = Color3.fromRGB(247, 183, 68), Danger = Color3.fromRGB(241, 83, 91), Info = Color3.fromRGB(103, 158, 255),
	},
}

function Themes.get(name)
	return Themes.Definitions[name]
end

function Themes.resolve(theme)
	if type(theme) == "table" then return theme end
	return Themes.get(theme or "Obsidian") or Themes.Definitions.Obsidian
end

function Themes.register(name, definition)
	Themes.Definitions[name] = definition
end

return Themes
