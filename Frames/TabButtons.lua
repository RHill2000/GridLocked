local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

local function onTabChanged()
	local selection = frames.MainFrame.selectedTab
	local tabFrames = {
		frames.GridTabFrame,
		frames.UnlocksTabFrame,
		frames.SettingsTabFrame,
		frames.HelpTabFrame,
	}

	for index, value in ipairs(tabFrames) do
		if index == selection then
			value:Show()
		else
			value:Hide()
		end
	end
end

local function createTabButton(id, label)
	local tabName = frames.MainFrame:GetName() .. "Tab" .. id
	local tabButton = CreateFrame("Button", tabName, frames.MainFrame, ns.consts.TAB_TEMPLATES[1])

	tabButton:SetID(id)
	tabButton:SetText(label)
	tabButton:SetScript("OnClick", function(self)
		PanelTemplates_SetTab(frames.MainFrame, self:GetID())
		frames.MainFrame.selectedTab = self:GetID()
		onTabChanged()
	end)

	if id == 1 then
		tabButton:SetPoint("TOPLEFT", frames.MainFrame, "BOTTOMLEFT", 0, 1)
	else
		tabButton:SetPoint("LEFT", frames.MainFrame:GetName() .. "Tab" .. (id - 1), "RIGHT", 0, 0)
	end

	tabButton:HookScript("OnShow", function()
		PanelTemplates_TabResize(tabButton, 0, nil, 75)
	end)

	return tabButton
end

function ui.CreateTabButtons()
	PanelTemplates_SetNumTabs(frames.MainFrame, 4)
	frames.MainFrame.tabs = frames.MainFrame.tabs or {}

	frames.MainFrame.tabs[1] = createTabButton(1, "Grid")
	frames.MainFrame.tabs[2] = createTabButton(2, "Unlocks")
	frames.MainFrame.tabs[3] = createTabButton(3, "Settings")
	frames.MainFrame.tabs[4] = createTabButton(4, "Help")

	PanelTemplates_SetTab(frames.MainFrame, 1)
	frames.MainFrame.selectedTab = 1
	onTabChanged()
end
