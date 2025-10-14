local _, ns = ...

local utils = ns.utils
ns.utils = utils

function utils.toggleUI()
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

function utils.colourString(string, colour)
	if not colour then
		return string.format("|c%s%s|r", ns.consts.COLOUR, string)
	else
		return string.format("|c%s%s|r", colour, string)
	end
end
function utils.repaintTile(id)
	local GridLockedFrame = type(ns.frames.GridLockedFrame) == "table" and ns.frames.GridLockedFrame or nil
	if GridLockedFrame and GridLockedFrame.tiles and GridLockedFrame.tiles[id] then
		GridLockedFrame.tiles[id]:paint()
	end
end

function utils.RefreshTileVisibility()
	local GridLockedFrame = type(ns.frames.GridLockedFrame) == "table" and ns.frames.GridLockedFrame or nil
	if GridLockedFrame and GridLockedFrame.UpdateTileVisibility then
		GridLockedFrame:UpdateTileVisibility()
	end
end

function utils.UnlockNeighbors(profile, tileId)
	local r, c = tileId:match("(%d+)_(%d+)")
	r, c = tonumber(r), tonumber(c)
	for _, d in ipairs(ns.consts.NEIGHBOR_OFFSETS) do
		local rr, cc = r + d[1], c + d[2]
		if rr >= 1 and rr <= profile.gridSize and cc >= 1 and cc <= profile.gridSize then
			local nid = string.format("%d_%d", rr, cc)
			local t = profile.tiles[nid]
			if t and t.state == "locked" then
				t.state = "unlocked"
				ns.utils.repaintTile(nid)
			end
		end
	end
	if utils.RefreshTileVisibility then
		utils.RefreshTileVisibility()
	end
end

function utils.completeChallenge(profile, ch)
	if ch.status == "done" then return end
	ch.status = "done"

	for tileId, tile in pairs(profile.tiles) do
		if tile.challengeId == ch.id then
			tile.state = "complete"
			print("|cff00ff00GridLocked|r: Completed -> " .. (ch.label or ch.id))
			utils.repaintTile(tileId)
			utils.UnlockNeighbors(profile, tileId)
			return
		end
	end
end

function utils.chooseDefaultIcon(ch)
	if ch.type == "kill" then return ns.consts.ICONS.kill end
	if ch.type == "gather" then
		if ch.params and ch.params.nodeType == "herb" then return ns.consts.ICONS.gather_h end
		if ch.params and ch.params.nodeType == "ore" then return ns.consts.ICONS.gather_o end
		return ns.consts.ICONS.gather_h
	end
	if ch.type == "explore" then return ns.consts.ICONS.explore end
	return ns.consts.ICONS.meta
end

function utils.challengeTemplateForCoord(r, c)
	local tileId = string.format("%d_%d", r, c)
	local sum = r + c

	local chType, params, label
	if sum % 5 == 0 then
		chType, params, label = "explore", { zoneName = "Westfall" }, "Visit Westfall"
	elseif sum % 3 == 0 then
		chType, params, label = "gather", { nodeType = "ore", count = 8 }, "Mine 8 nodes"
	elseif sum % 2 == 0 then
		chType, params, label = "gather", { nodeType = "herb", count = 8 }, "Gather 8 herbs"
	else
		chType, params, label = "kill", { count = 10 }, "Kill 10 mobs"
	end

	local ch = {
		id = "C-" .. tileId,
		type = chType,
		params = params,
		progress = 0,
		status = "pending",
		label = label,
	}
	ch.icon = utils.chooseDefaultIcon(ch)
	return ch
end

function utils.ensureTileAndChallenge(profile, r, c)
	local tileId = string.format("%d_%d", r, c)
	local chId = "C-" .. tileId

	profile.challenges = profile.challenges or {}
	local ch = profile.challenges[chId]
	local createdChallenge = false
	if not ch then
		ch = utils.challengeTemplateForCoord(r, c)
		profile.challenges[chId] = ch
		createdChallenge = true
	else
		ch.icon = ch.icon or utils.chooseDefaultIcon(ch)
	end

	profile.tiles = profile.tiles or {}
	local tile = profile.tiles[tileId]
	local createdTile = false
	if not tile then
		tile = { state = "locked", challengeId = chId }
		profile.tiles[tileId] = tile
		createdTile = true
	else
		tile.challengeId = tile.challengeId or chId
	end

	return tile, createdTile, createdChallenge
end

function utils.seedGrid(profile, size, opts)
	if not size or size < 1 then return end

	local settings = opts or {}
	local startRow = math.floor(size / 2) + 1
	local startCol = math.floor(size / 2) + 1
	for r = 1, size do
		for c = 1, size do
			local tile, createdTile = utils.ensureTileAndChallenge(profile, r, c)
			if r == startRow and c == startCol then
				if tile.state ~= "complete" then
					tile.state = "unlocked"
				end
				settings.startTile = tile
			end
		end
	end

	profile.gridSize = size
	profile.startTile = settings.startTile
end

function utils.tilePixels(count, scale)
	count = math.max(count or 0, 1)
	scale = scale or 1
	local tile = ns.consts.SIZE * scale
	local gap = ns.consts.GRID_PADDING * scale
	return (count * (tile + gap)) - gap
end

function utils.isUnlockedState(state)
	return state == "unlocked" or state == "complete"
end

function utils.tileKey(r, c)
	return string.format("%d_%d", r, c)
end

function utils.setIconFromChallenge(btn)
	local profile = ns.profile.ensureProfile()
	local tile = profile.tiles[btn.id]
	if not tile then return end
	local ch = profile.challenges[tile.challengeId]
	if not ch then
		btn.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		return
	end
	local tex = ch.icon or utils.chooseDefaultIcon(ch) or "Interface\\Icons\\INV_Misc_QuestionMark"
	btn.icon:SetTexture(tex)
end

function utils.applyStateTint(btn)
	local profile = ns.profile.ensureProfile()
	local tile = profile.tiles[btn.id]
	local state = tile and tile.state or "locked"

	if state == "locked" then
		btn.icon:SetDesaturated(true)
		btn.overlay:Show()
		btn.overlay:SetVertexColor(0, 0, 0, 0.50)
	elseif state == "unlocked" then
		btn.icon:SetDesaturated(false)
		btn.overlay:Show()
		btn.overlay:SetVertexColor(0.2, 0.4, 1.0, 0.20)
	elseif state == "complete" then
		btn.icon:SetDesaturated(false)
		btn.overlay:Show()
		btn.overlay:SetVertexColor(0.2, 1.0, 0.2, 0.25)
	else
		btn.icon:SetDesaturated(false)
		btn.overlay:Hide()
	end
end
