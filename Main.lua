local _, ns = ...

local EventFrame = CreateFrame("Frame")
ns.EventFrame = EventFrame

EventFrame:RegisterEvent("PLAYER_LOGIN")

EventFrame:SetScript("OnEvent", function(_, event, ...)
	if event == "PLAYER_LOGIN" then
		print("|cffffcc00GridLocked|r loaded. Type |cffffff00/gl|r to open.")
	end
end)

local function ToggleUI()
	if not ns.frames.GridLockedFrame then
		ns.ui.CreateGridLockedFrame()
		table.insert(UISpecialFrames, ns.frames.GridLockedFrame:GetName())
		ns.frames.GridLockedFrame:Hide()
	end

	if ns.frames.GridLockedFrame:IsShown() then
		ns.frames.GridLockedFrame:Hide()
	else
		ns.frames.GridLockedFrame:Show()
	end
end

SLASH_GRIDLOCKED1 = "/gl"
SlashCmdList["GRIDLOCKED"] = ToggleUI
