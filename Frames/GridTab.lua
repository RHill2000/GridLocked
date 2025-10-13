local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

function ui.CreateGridTabFrame()
	frames.GridTabFrame = CreateFrame("Frame", "GridLockedGridTabFrame", frames.GridLockedFrame)

	frames.GridContainerFrame = CreateFrame("Frame", "GridLockedGridContainerFrame", frames.GridTabFrame, "InsetFrameTemplate")
	frames.GridContainerFrame:SetPoint("TOPLEFT", frames.GridLockedFrame, "TOPLEFT", 300, -20 - ns.consts.GRID_PADDING)
	frames.GridContainerFrame:SetPoint("BOTTOMRIGHT", frames.GridLockedFrame, "BOTTOMRIGHT", -ns.consts.GRID_PADDING, ns.consts.GRID_PADDING)

	frames.GridFrame = CreateFrame("ScrollFrame", "GridLockedGridFrame", frames.GridContainerFrame)
	frames.GridFrame:SetPoint("CENTER")
	frames.GridFrame:SetSize(ns.consts.GRID_WIDTH, ns.consts.GRID_HEIGHT)
	frames.GridFrame:SetClipsChildren(true)

	frames.Grid = CreateFrame("Frame", "GridLockedGrid", frames.GridFrame)
	frames.Grid:SetPoint("TOPLEFT")

	frames.GridFrame:SetScrollChild(frames.Grid)
end
