local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

function ui.CreateSettingsTabFrame()
	frames.SettingsTabFrame = CreateFrame("Frame", "GridLockedSettingsTabFrame", frames.MainFrame)
end
