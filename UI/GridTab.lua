local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

function ui.CreateGridTabFrame()
	frames.GridTabFrame = CreateFrame("Frame", "GridTabFrame", frames.GridLockedFrame)

	frames.GridContainerFrame = CreateFrame("Frame", "GridContainerFrame", frames.GridTabFrame, "InsetFrameTemplate")
	frames.GridContainerFrame:SetPoint("TOPLEFT", frames.GridLockedFrame, "TOPLEFT", 300, -20 - ns.consts.GRID_PADDING)
	frames.GridContainerFrame:SetPoint("BOTTOMRIGHT", frames.GridLockedFrame, "BOTTOMRIGHT", -ns.consts.GRID_PADDING, ns.consts.GRID_PADDING)

	frames.GridFrame = CreateFrame("ScrollFrame", "GridFrame", frames.GridContainerFrame)
	frames.GridFrame:SetPoint("CENTER")
	frames.GridFrame:SetSize(ns.consts.GRID_WIDTH, ns.consts.GRID_HEIGHT)
	frames.GridFrame:SetClipsChildren(true)

	frames.Grid = CreateFrame("Frame", "Grid", frames.GridFrame)
	frames.Grid:SetPoint("TOPLEFT")

	frames.GridFrame:SetScrollChild(frames.Grid)
end
