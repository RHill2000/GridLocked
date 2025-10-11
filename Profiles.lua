local _, ns = ...
local profiles = ns.profiles

function profiles.charKey()
  local name, realm = UnitName("player"), GetRealmName()
  return realm .. "-" .. name
end

function profiles.ensureProfile()
  local key = profiles.charKey()
  GridLockedDB.profiles = GridLockedDB.profiles or {}
  GridLockedDB.profiles[key] = GridLockedDB.profiles[key] or {}
  local profile = GridLockedDB.profiles[key]

  if not profile.initialized then
    for k,v in pairs(ns.config.DEFAULT_CONFIG) do
      if profile[k] == nil then
        if type(v) == "table" then profile[k] = {} else profile[k] = v end
      end
    end
  end

  profile.tiles = profile.tiles or {}
  profile.challenges = profile.challenges or {}

  local desiredSize = math.max(profile.gridSize or 0, ns.config.DEFAULT_CONFIG.gridSize)
  ns.utils.seedGrid(profile, desiredSize)

  return profile
end
