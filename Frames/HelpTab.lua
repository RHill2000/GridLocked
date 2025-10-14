local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

function ui.CreateHelpTabFrame()
	frames.HelpTabFrame = CreateFrame("Frame", "GridLockedHelpTabFrame", frames.GridLockedFrame)
end
