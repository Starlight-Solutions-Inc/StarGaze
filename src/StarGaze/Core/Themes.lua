local Themes = {}

Themes.Definitions = {
	Obsidian = {
		Background = Color3.fromRGB(8, 9, 12),
		Surface = Color3.fromRGB(14, 16, 21),
		SurfaceAlt = Color3.fromRGB(20, 23, 30),
		SurfaceRaised = Color3.fromRGB(25, 28, 36),
		Glass = Color3.fromRGB(18, 20, 27),
		Border = Color3.fromRGB(48, 53, 66),
		BorderSoft = Color3.fromRGB(34, 38, 48),
		Text = Color3.fromRGB(244, 246, 250),
		Subtext = Color3.fromRGB(150, 156, 171),
		Muted = Color3.fromRGB(99, 106, 121),
		Accent = Color3.fromRGB(144, 97, 255),
		AccentHover = Color3.fromRGB(166, 125, 255),
		AccentPressed = Color3.fromRGB(119, 75, 228),
		Success = Color3.fromRGB(74, 211, 132),
		Warning = Color3.fromRGB(245, 182, 67),
		Danger = Color3.fromRGB(242, 83, 86),
		Info = Color3.fromRGB(84, 157, 255),
	},
	Midnight = {
		Background = Color3.fromRGB(6, 10, 18),
		Surface = Color3.fromRGB(11, 17, 28),
		SurfaceAlt = Color3.fromRGB(16, 25, 39),
		SurfaceRaised = Color3.fromRGB(22, 33, 49),
		Glass = Color3.fromRGB(16, 24, 39),
		Border = Color3.fromRGB(42, 62, 88),
		BorderSoft = Color3.fromRGB(29, 42, 60),
		Text = Color3.fromRGB(241, 246, 255),
		Subtext = Color3.fromRGB(143, 157, 180),
		Muted = Color3.fromRGB(94, 108, 130),
		Accent = Color3.fromRGB(75, 144, 255),
		AccentHover = Color3.fromRGB(107, 163, 255),
		AccentPressed = Color3.fromRGB(53, 117, 226),
		Success = Color3.fromRGB(74, 215, 141),
		Warning = Color3.fromRGB(245, 184, 73),
		Danger = Color3.fromRGB(239, 82, 95),
		Info = Color3.fromRGB(78, 170, 255),
	},
	Carbon = {
		Background = Color3.fromRGB(3, 4, 5),
		Surface = Color3.fromRGB(9, 10, 12),
		SurfaceAlt = Color3.fromRGB(15, 17, 20),
		SurfaceRaised = Color3.fromRGB(20, 22, 26),
		Glass = Color3.fromRGB(16, 18, 21),
		Border = Color3.fromRGB(39, 42, 47),
		BorderSoft = Color3.fromRGB(27, 30, 34),
		Text = Color3.fromRGB(246, 246, 247),
		Subtext = Color3.fromRGB(151, 154, 159),
		Muted = Color3.fromRGB(97, 101, 107),
		Accent = Color3.fromRGB(224, 225, 232),
		AccentHover = Color3.fromRGB(246, 247, 250),
		AccentPressed = Color3.fromRGB(187, 188, 195),
		Success = Color3.fromRGB(80, 212, 131),
		Warning = Color3.fromRGB(244, 183, 65),
		Danger = Color3.fromRGB(240, 83, 85),
		Info = Color3.fromRGB(92, 154, 255),
	},
	Violet = {
		Background = Color3.fromRGB(10, 6, 15),
		Surface = Color3.fromRGB(20, 12, 28),
		SurfaceAlt = Color3.fromRGB(27, 16, 38),
		SurfaceRaised = Color3.fromRGB(35, 21, 48),
		Glass = Color3.fromRGB(26, 16, 37),
		Border = Color3.fromRGB(67, 42, 85),
		BorderSoft = Color3.fromRGB(47, 29, 61),
		Text = Color3.fromRGB(248, 243, 255),
		Subtext = Color3.fromRGB(164, 145, 176),
		Muted = Color3.fromRGB(109, 89, 121),
		Accent = Color3.fromRGB(178, 89, 255),
		AccentHover = Color3.fromRGB(201, 126, 255),
		AccentPressed = Color3.fromRGB(148, 67, 218),
		Success = Color3.fromRGB(76, 215, 137),
		Warning = Color3.fromRGB(244, 181, 68),
		Danger = Color3.fromRGB(240, 82, 90),
		Info = Color3.fromRGB(103, 158, 255),
	},
}

function Themes.get(name)
	return Themes.Definitions[name]
end

function Themes.resolve(theme)
	if type(theme) == "table" then
		return theme
	end
	return Themes.get(theme or "Obsidian") or Themes.Definitions.Obsidian
end

function Themes.register(name, definition)
	Themes.Definitions[name] = definition
end

return Themes
