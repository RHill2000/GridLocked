local GridLocked, ns = ...

local EventFrame = CreateFrame("Frame")
ns.EventFrame = EventFrame

EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("PLAYER_LOGIN")

EventFrame:SetScript("OnEvent", function(_, event, ...)
	if event == "ADDON_LOADED" then
		ns.ui.CreateGridLockedFrame()
		ns.frames.GridLockedFrame:Hide()
		table.insert(UISpecialFrames, ns.frames.GridLockedFrame:GetName())
	end

	if event == "PLAYER_LOGIN" then
		print("|cffffcc00GridLocked|r loaded. Type |cffffff00/gl|r to open.")
	end
end)

local function ToggleUI()
	if ns.frames.GridLockedFrame:IsShown() then
		ns.frames.GridLockedFrame:Hide()
	else
		ns.frames.GridLockedFrame:Show()
	end
end

SLASH_GRIDLOCKED1 = "/gl"
SlashCmdList["GRIDLOCKED"] = ToggleUI

-- function HandleResetSlash()
--   local key = ns.profile.charKey()
--   GridLockedDB.profile = GridLockedDB.profile or {}
--   GridLockedDB.profile[key] = nil
--   print("|cffff5555GridLocked|r: Profile reset. /reload recommended.")
-- end

-- SLASH_GRIDLOCKEDRESET1 = "/glreset"
-- SlashCmdList["GRIDLOCKEDRESET"] = HandleResetSlash
