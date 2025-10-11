local _, ns = ...
local config = ns.config

config.DEFAULT_CONFIG = {
  gridSize = 13,
  tiles = {},
  challenges = {},
}

config.SIZE = 35
config.GRID_PADDING  = 8
config.VIEW_TILES = 13
config.ZOOM_MIN = 1
config.ZOOM_MAX = 2.5
config.ZOOM_STEP = 0.25

config.NEIGHBOR_OFFSETS = {{1,0},{-1,0},{0,1},{0,-1}}

config.ICONS = {
  kill     = "Interface\\Icons\\Ability_CriticalStrike",
  gather_h = "Interface\\Icons\\Trade_Herbalism",
  gather_o = "Interface\\Icons\\Trade_Mining",
  explore  = "Interface\\Icons\\INV_Misc_Map02",
  meta     = "Interface\\Icons\\Achievement_General",
}