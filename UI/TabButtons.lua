local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

function ui.CreateTabButtons()
	local function onTabChanged()
		if frames.GridLockedFrame.selectedTab == 1 then
			frames.UnlocksTabFrame:Hide()
			frames.GridTabFrame:Show()
		else
			frames.UnlocksTabFrame:Show()
			frames.GridTabFrame:Hide()
		end
	end

	local tabs = {
		{ text = "Grid" },
		{ text = "Unlocks" },
	}

	PanelTemplates_SetNumTabs(frames.GridLockedFrame, #tabs)
	frames.GridLockedFrame.tabs = frames.GridLockedFrame.tabs or {}

	for i, info in ipairs(tabs) do
		local tab = CreateFrame("Button", ("GridLockedFrameTab%d"):format(i), frames.GridLockedFrame, "CharacterFrameTabButtonTemplate")
		tab:SetID(i)
		tab:SetText(info.text)
		tab:SetScript("OnClick", function(self)
			PanelTemplates_SetTab(frames.GridLockedFrame, self:GetID())
			frames.GridLockedFrame.selectedTab = self:GetID()
			onTabChanged()
		end)
		if i == 1 then
			tab:SetPoint("TOPLEFT", frames.GridLockedFrame, "BOTTOMLEFT", 0, 1)
		else
			tab:SetPoint("TOPLEFT", ("GridLockedFrameTab%d"):format(i - 1), "TOPRIGHT", -15, 1)
		end
		PanelTemplates_TabResize(tab, 0, nil, 72)
		frames.GridLockedFrame.tabs[i] = tab
	end

	PanelTemplates_SetTab(frames.GridLockedFrame, 1)
	frames.GridLockedFrame.selectedTab = 1
	onTabChanged()
end
