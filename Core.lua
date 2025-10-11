local GridLocked, ns = ...
ns.GridLocked = GridLocked
ns.profiles = {}
ns.config = {}
ns.frames = {}
ns.utils = {}
ns.handlers = {}

GridLockedDB = GridLockedDB or {}

GridLockedFrame = CreateFrame("Frame")
GridLockedFrame:RegisterEvent("PLAYER_LOGIN")
GridLockedFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
GridLockedFrame:RegisterEvent("CHAT_MSG_LOOT")
GridLockedFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

GridLockedFrame:SetScript("OnEvent", function(_, event, ...)
  local profile = ns.profiles.ensureProfile()

  if event == "PLAYER_LOGIN" then
    print("|cffffcc00GridLocked|r loaded. Type |cffffff00/gl|r to open.")
    return
  end

  -- if event == "COMBAT_LOG_EVENT_UNFILTERED" then
  --   for _, ch in pairs(profile.challenges) do
  --     if ch.type == "kill" then ns.handlers.handlers["kill"](profile, ch) end
  --   end
  --   return
  -- end

  -- if event == "CHAT_MSG_LOOT" then
  --   local msg = ...
  --   for _, ch in pairs(profile.challenges) do
  --     if ch.type == "gather" then ns.handlers.handlers["gather"](profile, ch, msg) end
  --   end
  --   return
  -- end

  -- if event == "ZONE_CHANGED_NEW_AREA" then
  --   for _, ch in pairs(profile.challenges) do
  --     if ch.type == "explore" then ns.handlers.handlers["explore"](profile, ch) end
  --   end
  --   return
  -- end
end)

local function ensureMainFrame()
  if type(ns.frames.MainFrame) == "function" then
    ns.frames.MainFrame = ns.frames.MainFrame()
  end
  return ns.frames.MainFrame
end

function ToggleUI()
  local mainFrame = ensureMainFrame()
  if not mainFrame then return end

  if mainFrame:IsShown() then
    mainFrame:Hide()
  else
    mainFrame:Show()
  end
end

function HandleToggleSlash()
  ToggleUI()
end

function HandleResetSlash()
  local key = ns.profiles.charKey()
  GridLockedDB.profiles = GridLockedDB.profiles or {}
  GridLockedDB.profiles[key] = nil
  print("|cffff5555GridLocked|r: Profile reset. /reload recommended.")
end

SLASH_GRIDLOCKED1 = "/gl"
SlashCmdList["GRIDLOCKED"] = HandleToggleSlash

SLASH_GRIDLOCKEDRESET1 = "/glreset"
SlashCmdList["GRIDLOCKEDRESET"] = HandleResetSlash
