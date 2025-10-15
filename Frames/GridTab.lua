local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

function ui.CreateGridTabFrame()
	local mainframe = frames.MainFrame

	frames.GridTabFrame = CreateFrame("Frame", "GridLockedGridTabFrame", mainframe)
	local currentTab = frames.GridTabFrame

	currentTab.AvailableUnlocksText = currentTab:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	currentTab.AvailableUnlocksText:SetPoint("TOP", mainframe.TitleText, "BOTTOM", -270, -25)
	currentTab.AvailableUnlocksText:SetText(string.format("Available Unlocks: %d", 0))
	currentTab.AvailableUnlocksText:SetTextColor(1, 0, 0)

	currentTab.CurrentChallengeFrame = CreateFrame("Frame", "GridLockedCurrentChallengeFrame", currentTab, "GridLockedDialogTemplate")
	ns.utils.SetFrameLocation(currentTab.CurrentChallengeFrame, 280, 120, mainframe, 10, -72)
	currentTab.CurrentChallengeFrame.TitleContainer.TitleText:SetText("Current Challenge")
	currentTab.GridContainerFrame = CreateFrame("Frame", "GridLockedGridContainerFrame", currentTab, "InsetFrameTemplate")
	ns.utils.SetFrameLocation(
		currentTab.GridContainerFrame,
		ns.consts.MAINFRAME_WIDTH - ns.consts.GRID_PADDING - 301, ns.consts.MAINFRAME_HEIGHT - (ns.consts.GRID_PADDING * 4) - 4,
		mainframe,
		300, -20 - ns.consts.GRID_PADDING
	)

	-- currentTab.GridFrame = CreateFrame("ScrollFrame", "GridLockedGridFrame", currentTab.GridContainerFrame)
	-- currentTab.GridFrame:SetPoint("CENTER")
	-- currentTab.GridFrame:SetSize(ns.consts.GRID_WIDTH, ns.consts.GRID_HEIGHT)
	-- currentTab.GridFrame:SetClipsChildren(true)

	-- currentTab.Grid = CreateFrame("Frame", "GridLockedGrid", currentTab.GridFrame)
	-- currentTab.Grid:SetPoint("TOPLEFT")

	-- currentTab.GridFrame:SetScrollChild(currentTab.Grid)
end
