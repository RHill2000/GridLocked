local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

local function onTabChanged()
	local selection = frames.GridLockedFrame.selectedTab

	if selection == 1 then
		frames.GridTabFrame:Show()
		frames.UnlocksTabFrame:Hide()
		frames.SettingsTabFrame:Hide()
	elseif selection == 2 then
		frames.GridTabFrame:Hide()
		frames.UnlocksTabFrame:Show()
		frames.SettingsTabFrame:Hide()
	else
		frames.GridTabFrame:Hide()
		frames.UnlocksTabFrame:Hide()
		frames.SettingsTabFrame:Show()
	end
end

local function createTabButton(id, label, anchor)
	local tabName = anchor:GetName() .. "Tab" .. id
	local tabButton = CreateFrame("Button", tabName, anchor, "CharacterFrameTabButtonTemplate")

	tabButton:SetID(id)
	tabButton:SetText(label)
	tabButton:SetScript("OnClick", function(self)
		PanelTemplates_SetTab(anchor, self:GetID())
		frames.GridLockedFrame.selectedTab = self:GetID()
		onTabChanged()
	end)

	if id == 1 then
		tabButton:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 15, 0)
	else
		tabButton:SetPoint("LEFT", _G[anchor:GetName() .. "Tab" .. (id - 1)], "RIGHT", 15, 0)
	end

	PanelTemplates_TabResize(tabButton, 0, nil, 30, 30)

	return tabButton
end

function ui.CreateTabButtons()
	frames.GridTabButton = createTabButton(1, "Grid", frames.GridLockedFrame)
	frames.UnlocksTabButton = createTabButton(2, "Unlocks", frames.GridLockedFrame)
	frames.SettingsTabButton = createTabButton(3, "Settings", frames.GridLockedFrame)

	PanelTemplates_SetNumTabs(frames.GridLockedFrame, 3)
	PanelTemplates_SetTab(frames.GridLockedFrame, 1)
	frames.GridLockedFrame.numTabs = 3
	frames.GridLockedFrame.selectedTab = 1

	onTabChanged()
end
