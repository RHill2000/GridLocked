local _, ns = ...

local consts = ns.consts or {}
ns.consts = consts

consts.DEFAULT_CONFIG = {
	gridSize = 13,
	tiles = {},
	challenges = {},
}

consts.SIZE = 35
consts.GRID_PADDING = 8
consts.VIEW_TILES = 13
consts.ZOOM_MIN = 1
consts.ZOOM_MAX = 2.5
consts.ZOOM_STEP = 0.25

consts.NEIGHBOR_OFFSETS = { { 1, 0 }, { -1, 0 }, { 0, 1 }, { 0, -1 } }

consts.ICONS = {
	kill     = "Interface\\Icons\\Ability_CriticalStrike",
	gather_h = "Interface\\Icons\\Trade_Herbalism",
	gather_o = "Interface\\Icons\\Trade_Mining",
	explore  = "Interface\\Icons\\INV_Misc_Map02",
	meta     = "Interface\\Icons\\Achievement_General",
}
