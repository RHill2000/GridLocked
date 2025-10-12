local _, ns = ...

local profile = ns.profile or {}
ns.profile = profile

function profile.charKey()
	local name, realm = UnitName("player"), GetRealmName()
	return realm .. "-" .. name
end

function profile.ensureProfile()
	local key = profile.charKey()
	GridLockedDB.profile = GridLockedDB.profile or {}
	GridLockedDB.profile[key] = GridLockedDB.profile[key] or {}
	local profile = GridLockedDB.profile[key]

	if not profile.initialized then
		for k, v in pairs(ns.consts.DEFAULT_CONFIG) do
			if profile[k] == nil then
				if type(v) == "table" then profile[k] = {} else profile[k] = v end
			end
		end
	end

	profile.tiles = profile.tiles or {}
	profile.challenges = profile.challenges or {}

	local desiredSize = math.max(profile.gridSize or 0, ns.consts.DEFAULT_CONFIG.gridSize)
	ns.utils.seedGrid(profile, desiredSize)

	return profile
end
