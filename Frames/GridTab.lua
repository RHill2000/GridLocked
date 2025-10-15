local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

local function CreateProgressBar(parent, width, height, r, g, b)
    local bar = CreateFrame("StatusBar", nil, parent)
    bar:SetSize(width, height)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetStatusBarColor(r, g, b)
    bar:SetMinMaxValues(0, 100)
    bar:SetValue(0)

    -- border
    local border = CreateFrame("Frame", nil, bar, "BackdropTemplate")
	border:SetAllPoints(true)
	border:SetPoint("TOPLEFT", -2, 3)
	border:SetPoint("BOTTOMRIGHT", 2, -3)
    border:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 15,
    })
    border:SetBackdropBorderColor(0.8, 0.8, 0.8)

    -- label
    bar.Text = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    bar.Text:SetPoint("CENTER")

    return bar
end

local function CreateLockedText(currentFrame, level)
	local text = currentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	text:SetPoint("CENTER", currentFrame, 0, -5)
	text:SetText(string.format("Unlocked at Level %d", level))
	text:SetTextColor(1, 1, 1)
	text:SetAlpha(0.5)

	return text
end

local function CreateLockedButton(currentFrame, onClick)
	local button = CreateFrame("Button", nil, currentFrame, "UIPanelButtonTemplate")
	button:SetSize(120, 25)
	button:SetPoint("CENTER", currentFrame, 0, -5)
	button:SetText("Unlock")
	button:SetScript("OnClick", onClick)

	return button
end

local function createCurrentChallengeFrame(currentTab, mainframe)
	currentTab.CurrentChallengeFrame = ns.utils.CreateCustomDialogFrame(currentTab, "Current Challenge", 10, -72)
	local currentFrame = currentTab.CurrentChallengeFrame

	local bar = CreateProgressBar(currentFrame, currentFrame:GetWidth() - 30, 18, 0.3, 0.7, 0.2)
	bar:SetPoint("BOTTOM", 1, 18)
	bar:SetValue(100)
	bar.Text:SetText(string.format("%d/%d", 5, 12))
	-- when complete, change to a complete/claim button
end

local function createHintsFrame(currentTab, mainframe)
	currentTab.HintsFrame = ns.utils.CreateCustomDialogFrame(currentTab, "Hints", 10, -200)
	local currentFrame = currentTab.HintsFrame

	currentFrame.LockedText = CreateLockedText(currentFrame, 5)
	currentFrame.UnlockButton = CreateLockedButton(currentFrame)

end

local function createDeathsFrame(currentTab, mainframe)
	currentTab.DeathsFrame = ns.utils.CreateCustomDialogFrame(currentTab, "Deaths", 10, -328)
	local currentFrame = currentTab.DeathsFrame

	currentFrame.LockedText = CreateLockedText(currentFrame, 10)
	currentFrame.UnlockButton = CreateLockedButton(currentFrame)
end

local function createRerollsFrame(currentTab, mainframe)
	currentTab.RerollFrame = ns.utils.CreateCustomDialogFrame(currentTab, "Rerolls", 10, -456)
	local currentFrame = currentTab.RerollFrame

	currentFrame.LockedText = CreateLockedText(currentFrame, 15)
	currentFrame.UnlockButton = CreateLockedButton(currentFrame)
end

function ui.CreateGridTabFrame()
	local mainframe = frames.MainFrame

	frames.GridTabFrame = CreateFrame("Frame", "GridLockedGridTabFrame", mainframe)
	local currentTab = frames.GridTabFrame

	currentTab.AvailableUnlocksText = currentTab:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	currentTab.AvailableUnlocksText:SetPoint("TOP", mainframe.TitleText, "BOTTOM", -270, -25)
	currentTab.AvailableUnlocksText:SetText(string.format("Available Unlocks: %d", 0))
	currentTab.AvailableUnlocksText:SetTextColor(1, 0, 0)

	createCurrentChallengeFrame(currentTab, mainframe)
	createHintsFrame(currentTab, mainframe)
	createDeathsFrame(currentTab, mainframe)
	createRerollsFrame(currentTab, mainframe)

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
