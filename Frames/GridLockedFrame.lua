local _, ns = ...

local ui = ns.ui
ns.ui = ui
local frames = ns.frames
ns.frames = frames

function ui.CreateGridLockedFrame()
	local profile = ns.profile.ensureProfile()

	ns.consts.GRID_TILES = math.min(profile.gridSize, ns.consts.VIEW_TILES)
	ns.consts.GRID_WIDTH = ns.utils.tilePixels(ns.consts.GRID_TILES, 1) + (ns.consts.GRID_PADDING * 2)
	ns.consts.GRID_HEIGHT = ns.utils.tilePixels(ns.consts.GRID_TILES, 1) + (ns.consts.GRID_PADDING * 2)

	frames.GridLockedFrame = CreateFrame("Frame", "GridLockedFrame", UIParent, "PortraitFrameTemplate")
	frames.GridLockedFrame:SetSize(ns.consts.GRID_WIDTH + 300 + (ns.consts.GRID_PADDING * 2), ns.consts.GRID_HEIGHT + (ns.consts.GRID_PADDING * 5))
	frames.GridLockedFrame:SetPoint("CENTER")
	frames.GridLockedFrame.PortraitContainer.portrait:SetTexture("Interface/Icons/achievement_quests_completed_08")
	frames.GridLockedFrame.TitleText:SetText("GridLocked")
	frames.GridLockedFrame.tiles = {}
	table.insert(UISpecialFrames, frames.GridLockedFrame:GetName())

	ui.CreateGridTabFrame()
	ui.CreateUnlocksTabFrame()
	ui.CreateSettingsTabFrame()

	ui.CreateTabButtons()

	-- Current challenge
	-- local availableUnlocks = ns.frames.gridTabFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	-- availableUnlocks:SetPoint("TOP", ns.frames.gridLockedFrame.TitleText, "BOTTOM", -250, -20)
	-- availableUnlocks:SetText("Current Challenge")

	-- local function shouldShowTile(profile, row, col)
	--   local tile = profile.tiles[ns.utils.tileKey(row, col)]
	--   if not tile then return false end
	--   if ns.utils.isUnlockedState(tile.state) then return true end
	--   for _, offset in ipairs(ns.consts.NEIGHBOR_OFFSETS) do
	--     local neighbor = profile.tiles[ns.utils.tileKey(row + offset[1], col + offset[2])]
	--     if neighbor and ns.utils.isUnlockedState(neighbor.state) then
	--       return true
	--     end
	--   end
	--   return false
	-- end

	-- local function updateVisibility()
	--   local profile = ns.profile.ensureProfile()
	--   for id, btn in pairs(frames.gridLockedFrame.tiles or {}) do
	--     local visible = shouldShowTile(profile, btn.__row, btn.__col)
	--     if visible then
	--       btn:Show()
	--     else
	--       btn:Hide()
	--     end
	--   end
	-- end

	-- frames.GridLockedFrame.UpdateTileVisibility = updateVisibility

	-- local function layoutTiles(scale)
	--   scale = math.max(ns.consts.ZOOM_MIN, math.min(scale or frames.gridLockedFrame.zoom or 1, ns.consts.ZOOM_MAX))
	--   local strideBase = ns.consts.SIZE + ns.consts.GRID_PADDING
	--   local gridPixels = ns.utils.tilePixels(profile.gridSize, scale)
	--   local padActual = ns.consts.GRID_PADDING
	--   local padBase = ns.consts.GRID_PADDING / scale
	--   grid:SetSize(gridPixels + (padActual * 2), gridPixels + (padActual * 2))
	--   for _, btn in pairs(frames.gridLockedFrame.tiles) do
	--     btn:SetScale(scale)
	--     btn:SetSize(ns.consts.SIZE, ns.consts.SIZE)
	--     btn:ClearAllPoints()
	--     local offsetX = padBase + (btn.__col - 1) * strideBase
	--     local offsetY = padBase + (btn.__row - 1) * strideBase
	--     btn:SetPoint("TOPLEFT", grid, "TOPLEFT", offsetX, -offsetY)
	--   end
	--   updateVisibility()
	-- end

	-- local function getScrollBounds()
	--   local maxX = math.max(0, grid:GetWidth() - frames.gridFrame:GetWidth())
	--   local maxY = math.max(0, grid:GetHeight() - frames.gridFrame:GetHeight())
	--   return maxX, maxY
	-- end

	-- local function setPan(nx, ny)
	--   local maxX, maxY = getScrollBounds()
	--   frames.gridLockedFrame.panX = math.max(0, math.min(nx or 0, maxX))
	--   frames.gridLockedFrame.panY = math.max(0, math.min(ny or 0, maxY))
	--   frames.gridFrame:SetHorizontalScroll(frames.gridLockedFrame.panX)
	--   frames.gridFrame:SetVerticalScroll(frames.gridLockedFrame.panY)
	-- end

	-- local function hasPanRoom()
	--   local maxX, maxY = getScrollBounds()
	--   return maxX > 0 or maxY > 0
	-- end

	-- local panState = { active = false }

	-- local function stopPan()
	--   if not panState.active then return end
	--   panState.active = false
	--   frames.gridFrame:SetScript("OnUpdate", nil)
	-- end

	-- local function startPan()
	--   if not hasPanRoom() then return end
	--   local scale = frames.gridFrame:GetEffectiveScale()
	--   local cx, cy = GetCursorPosition()
	--   panState.active = true
	--   panState.startX = cx / scale
	--   panState.startY = cy / scale
	--   panState.originX = frames.gridLockedFrame.panX or 0
	--   panState.originY = frames.gridLockedFrame.panY or 0

	--   frames.gridFrame:SetScript("OnUpdate", function()
	--     local x, y = GetCursorPosition()
	--     x, y = x / scale, y / scale
	--     if not IsMouseButtonDown("RightButton") then
	--       stopPan()
	--       return
	--     end
	--     local dx = x - panState.startX
	--     local dy = y - panState.startY
	--     setPan(panState.originX - dx, panState.originY + dy)
	--   end)
	-- end

	-- local function applyZoom(newZoom, focusX, focusY)
	--   local previous = frames.gridLockedFrame.zoom or 1
	--   newZoom = math.max(ns.consts.ZOOM_MIN, math.min(newZoom or previous, ns.consts.ZOOM_MAX))
	--   if math.abs(newZoom - previous) < 0.001 then return end

	--   local width = frames.gridFrame:GetWidth()
	--   local height = frames.gridFrame:GetHeight()
	--   focusX = focusX or (width / 2)
	--   focusY = focusY or (height / 2)
	--   if focusX < 0 or focusX > width or focusY < 0 or focusY > height then
	--     focusX, focusY = width / 2, height / 2
	--   end

	--   local worldX = (frames.gridLockedFrame.panX or 0) + focusX
	--   local worldY = (frames.gridLockedFrame.panY or 0) + focusY
	--   local ratio = newZoom / previous

	--   layoutTiles(newZoom)
	--   frames.gridLockedFrame.zoom = newZoom
	--   zoomLevel = newZoom

	--   local newWorldX = worldX * ratio
	--   local newWorldY = worldY * ratio
	--   setPan(newWorldX - focusX, newWorldY - focusY)
	-- end

	-- frames.gridFrame:SetScript("OnMouseWheel", function(_, delta)
	--   if delta == 0 then return end
	--   local step = ns.consts.ZOOM_STEP
	--   local target = (frames.gridLockedFrame.zoom or 1) + (delta > 0 and step or -step)

	--   local scale = frames.gridFrame:GetEffectiveScale()
	--   local cursorX, cursorY = GetCursorPosition()
	--   cursorX, cursorY = cursorX / scale, cursorY / scale
	--   local left = frames.gridFrame:GetLeft() or 0
	--   local bottom = frames.gridFrame:GetBottom() or 0
	--   local focusX = cursorX - left
	--   local focusY = cursorY - bottom

	--   applyZoom(target, focusX, focusY)
	-- end)

	-- frames.gridFrame:SetScript("OnMouseDown", function(_, button)
	--   if button == "RightButton" then
	--     startPan()
	--   end
	-- end)
	-- frames.gridFrame:SetScript("OnMouseUp", stopPan)
	-- frames.gridFrame:SetScript("OnHide", stopPan)

	-- for r=1,profile.gridSize do
	--   for c=1,profile.gridSize do
	--     local id = string.format("%d_%d", r, c)
	--     local name = string.format("GridLockedTile_%s", id)
	--     local b = CreateFrame("Button", name, grid, "ItemButtonTemplate")
	--     b:SetSize(ns.consts.SIZE, ns.consts.SIZE)
	--     b:SetPoint("TOPLEFT", grid, "TOPLEFT", (c-1)*(ns.consts.SIZE+ns.consts.GRID_PADDING), -(r-1)*(ns.consts.SIZE+ns.consts.GRID_PADDING))
	--     b.__row = r
	--     b.__col = c
	--     b.id = id

	--     local icon = _G[name.."IconTexture"] or _G[name.."Icon"] or b.icon or b.Icon or b.IconTexture
	--     if not icon then
	--       icon = b:CreateTexture(nil, "ARTWORK")
	--       icon:SetAllPoints()
	--     end
	--     b.icon = icon
	--     b.icon:SetAllPoints()
	--     b.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

	--     b:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2")
	--     b:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
	--     b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

	--     b.overlay = b:CreateTexture(nil, "OVERLAY")
	--     b.overlay:SetAllPoints()
	--     b.overlay:SetTexture("Interface\\Buttons\\WHITE8x8")
	--     b.overlay:Hide()

	--     b.paint = function(self)
	--       ns.utils.setIconFromChallenge(self)
	--       ns.utils.applyStateTint(self)
	--     end
	--     b:paint()

	--     b:SetScript("OnEnter", function(self)
	--       self.overlay:Show()
	--       self.overlay:SetVertexColor(1,1,1,0.08)

	--       local tile = profile.tiles[self.id]
	--       local ch = tile and profile.challenges[tile.challengeId]
	--       GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	--       GameTooltip:AddLine(("Tile %s"):format(self.id))
	--       if ch then
	--         GameTooltip:AddLine(ch.label or ch.type or "Challenge", 1,1,1)
	--         local need = (ch.params and ch.params.count) or 1
	--         GameTooltip:AddLine(("Progress: %d / %d"):format(ch.progress or 0, need), .7,.7,.7)
	--         GameTooltip:AddLine(("Status: %s"):format(ch.status or "pending"), .7,.7,.7)
	--       end
	--       GameTooltip:Show()
	--     end)
	--     b:SetScript("OnLeave", function(self)
	--       ns.utils.applyStateTint(self)
	--       GameTooltip:Hide()
	--     end)

	--     b:SetScript("OnMouseDown", function(_, btn)
	--       if btn == "RightButton" then
	--         startPan()
	--       end
	--     end)
	--     b:SetScript("OnMouseUp", function(_, btn)
	--       if panState.active and btn == "RightButton" then
	--         stopPan()
	--       end
	--     end)
	--     b:SetScript("PreClick", function(self, btn)
	--       if btn == "RightButton" then
	--         self.__gridLockedSkipClick = true
	--       else
	--         self.__gridLockedSkipClick = nil
	--       end
	--     end)

	--     b:SetScript("OnClick", function(self, btn)
	--       if self.__gridLockedSkipClick then
	--         self.__gridLockedSkipClick = nil
	--         return
	--       end
	--       local tile = profile.tiles[self.id]
	--       if not tile then return end
	--       if btn == "RightButton" then
	--         local ch = profile.challenges[tile.challengeId]
	--         if ch and ch.status ~= "done" then
	--           ns.utils.completeChallenge(profile, ch)
	--           self:paint()
	--         end
	--       else
	--         if tile.state == "locked" then
	--           tile.state = "unlocked"
	--         elseif tile.state == "unlocked" then
	--           tile.state = "locked"
	--         end
	--         self:paint()
	--         ns.utils.RefreshTileVisibility()
	--       end
	--     end)

	--     frames.gridLockedFrame.tiles[id] = b
	--   end
	-- end

	-- layoutTiles(frames.gridLockedFrame.zoom)
	-- setPan(frames.gridLockedFrame.panX or 0, frames.gridLockedFrame.panY or 0)
end
