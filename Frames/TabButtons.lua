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

local function createTabButton(id, label)
	local tabName = frames.GridLockedFrame:GetName() .. "Tab" .. id
	local tabButton = CreateFrame("Button", tabName, frames.GridLockedFrame, ns.consts.TAB_TEMPLATES[1])

	tabButton:SetID(id)
	tabButton:SetText(label)
	tabButton:SetScript("OnClick", function(self)
		PanelTemplates_SetTab(frames.GridLockedFrame, self:GetID())
		frames.GridLockedFrame.selectedTab = self:GetID()
		onTabChanged()
	end)

	if id == 1 then
		tabButton:SetPoint("TOPLEFT", frames.GridLockedFrame, "BOTTOMLEFT", 0, 1)
	else
		tabButton:SetPoint("LEFT", frames.GridLockedFrame:GetName() .. "Tab" .. (id - 1), "RIGHT", 0, 1)
	end

	tabButton:HookScript("OnShow", function()
		PanelTemplates_TabResize(tabButton, 0, nil, 75)
	end)

	return tabButton
end

function ui.CreateTabButtons()
	PanelTemplates_SetNumTabs(frames.GridLockedFrame, 3)
	frames.GridLockedFrame.tabs = frames.GridLockedFrame.tabs or {}

	frames.GridLockedFrame.tabs[1] = createTabButton(1, "Grid")
	frames.GridLockedFrame.tabs[2] = createTabButton(2, "Unlocks")
	frames.GridLockedFrame.tabs[3] = createTabButton(3, "Settings")

	PanelTemplates_SetTab(frames.GridLockedFrame, 1)
	frames.GridLockedFrame.selectedTab = 1

	onTabChanged()
end
