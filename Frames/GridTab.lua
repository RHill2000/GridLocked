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
	currentTab.AvailableUnlocksText:SetPoint("TOP", mainframe.TitleText, "BOTTOM", -270, -20)
	currentTab.AvailableUnlocksText:SetText(string.format("Available Unlocks: %d", 0))
	currentTab.AvailableUnlocksText:SetTextColor(1, 0, 0)
	print(mainframe:GetHeight())
	
	currentTab.CurrentChallengeFrame = CreateFrame("Frame", "GridLockedCurrentChallengeFrame", currentTab, "InsetFrameTemplate2")
	currentTab.CurrentChallengeFrame:SetPoint("TOPLEFT", mainframe, "TOPLEFT", 20, -70)
	currentTab.CurrentChallengeFrame:SetPoint("BOTTOMRIGHT", mainframe, "BOTTOMRIGHT", -300, 600)

	currentTab.GridContainerFrame = CreateFrame("Frame", "GridLockedGridContainerFrame", currentTab, "InsetFrameTemplate")
	currentTab.GridContainerFrame:SetPoint("TOPLEFT", mainframe, "TOPLEFT", 300, -20 - ns.consts.GRID_PADDING)
	currentTab.GridContainerFrame:SetPoint("BOTTOMRIGHT", mainframe, "BOTTOMRIGHT", -ns.consts.GRID_PADDING, ns.consts.GRID_PADDING)

	-- currentTab.GridFrame = CreateFrame("ScrollFrame", "GridLockedGridFrame", currentTab.GridContainerFrame)
	-- currentTab.GridFrame:SetPoint("CENTER")
	-- currentTab.GridFrame:SetSize(ns.consts.GRID_WIDTH, ns.consts.GRID_HEIGHT)
	-- currentTab.GridFrame:SetClipsChildren(true)

	-- currentTab.Grid = CreateFrame("Frame", "GridLockedGrid", currentTab.GridFrame)
	-- currentTab.Grid:SetPoint("TOPLEFT")

	-- currentTab.GridFrame:SetScrollChild(currentTab.Grid)
end
