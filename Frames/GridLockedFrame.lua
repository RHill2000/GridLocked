local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

function ui.CreateGridLockedFrame()
	local profile = ns.profile.ensureProfile()

	ns.consts.GRID_TILES = math.min(profile.gridSize, ns.consts.VIEW_TILES)
	ns.consts.GRID_WIDTH = ns.utils.tilePixels(ns.consts.GRID_TILES, 1) + (ns.consts.GRID_PADDING * 2)
	ns.consts.GRID_HEIGHT = ns.utils.tilePixels(ns.consts.GRID_TILES, 1) + (ns.consts.GRID_PADDING * 2)

	frames.GridLockedFrame = CreateFrame("Frame", "GridLockedFrame", UIParent, "PortraitFrameTemplate")
	frames.GridLockedFrame:SetSize(ns.consts.GRID_WIDTH + 300 + (ns.consts.GRID_PADDING * 2), ns.consts.GRID_HEIGHT + (ns.consts.GRID_PADDING * 5))
	frames.GridLockedFrame:SetPoint("CENTER")
	frames.GridLockedFrame.PortraitContainer.portrait:SetTexture("Interface/Icons/achievement_quests_completed_08")
	frames.GridLockedFrame.TitleText:SetText("GridLocked")
	frames.GridLockedFrame.tiles = {}
	table.insert(UISpecialFrames, frames.GridLockedFrame:GetName())

	ui.CreateGridTabFrame()
	ui.CreateUnlocksTabFrame()
	ui.CreateSettingsTabFrame()

	ui.CreateTabButtons()
end
