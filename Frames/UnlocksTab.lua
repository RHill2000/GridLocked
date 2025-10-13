local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

function ui.CreateUnlocksTabFrame()
	frames.UnlocksTabFrame = CreateFrame("Frame", "GridLockedUnlocksTabFrame", frames.GridLockedFrame)
end
