local _, ns = ...

local EventFrame = CreateFrame("Frame")
ns.EventFrame = EventFrame

EventFrame:RegisterEvent("PLAYER_LOGIN")

EventFrame:SetScript("OnEvent", function(_, event, ...)
	if event == "PLAYER_LOGIN" then
		print(string.format(
			"%s: type %s or use the minimap button to open.",
			ns.utils.ColourString("[Grid Locked]"), ns.utils.ColourString("/gridlocked")
		))
	end
end)

SLASH_GRIDLOCKED1 = "/gridlocked"
SlashCmdList["GRIDLOCKED"] = ns.utils.ToggleUI
