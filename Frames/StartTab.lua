local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

function ui.CreateStartTabFrame()
	frames.StartTabFrame = CreateFrame("Frame", "GridLockedStartTabFrame", frames.MainFrame)
end
