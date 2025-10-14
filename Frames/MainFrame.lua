local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

function ui.CreateMainFrame()
	local profile = ns.profile.EnsureProfile()

	ns.consts.GRID_TILES = math.min(profile.gridSize, ns.consts.VIEW_TILES)
	ns.consts.GRID_WIDTH = ns.utils.TilePixels(ns.consts.GRID_TILES, 1) + (ns.consts.GRID_PADDING * 2)
	ns.consts.GRID_HEIGHT = ns.utils.TilePixels(ns.consts.GRID_TILES, 1) + (ns.consts.GRID_PADDING * 2)

	frames.MainFrame = CreateFrame("Frame", "MainFrame", UIParent, "PortraitFrameTemplate")
	frames.MainFrame:SetSize(ns.consts.GRID_WIDTH + 300 + (ns.consts.GRID_PADDING * 2), ns.consts.GRID_HEIGHT + (ns.consts.GRID_PADDING * 5))
	frames.MainFrame:SetPoint("CENTER")
	frames.MainFrame.PortraitContainer.portrait:SetTexture("Interface/Icons/achievement_quests_completed_08")
	frames.MainFrame.TitleText:SetText("Grid Locked")
	frames.MainFrame.tiles = {}
	table.insert(UISpecialFrames, frames.MainFrame:GetName())

	ns.consts.MAINFRAME_HEIGHT = frames.MainFrame:GetHeight()

	ui.CreateGridTabFrame()
	ui.CreateUnlocksTabFrame()
	ui.CreateSettingsTabFrame()
	ui.CreateHelpTabFrame()

	ui.CreateTabButtons()
end
