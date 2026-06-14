class_name LabTileSet

enum LabTileTexture {
	METAL_START_TOP,
	METAL_START_LEG,
	METAL_MIDDLE_TOP,
	METAL_END_TOP,
	METAL_END_LEG,
	GOOP_START_TOP,
	GOOP_MIDDLE_TOP_01,
	GOOP_MIDDLE_TOP_02,
	GOOP_END_TOP,
	WOOD_START_TOP,
	WOOD_START_LEG,
	WOOD_MIDDLE_TOP_PLAIN,
	WOOD_MIDDLE_TOP_OUTLET,
	WOOD_MIDDLE_TOP_GUM,
	WOOD_MIDDLE_LEG,
	WOOD_END_TOP,
	WOOD_END_LEG,
}

static var tileset: Dictionary[LabTileTexture, Vector2i] = {
	LabTileTexture.METAL_START_TOP: Vector2i(0, 0),
	LabTileTexture.METAL_START_LEG: Vector2i(0, 1),
	LabTileTexture.METAL_MIDDLE_TOP: Vector2i(1, 0),
	LabTileTexture.METAL_END_TOP: Vector2i(2, 0),
	LabTileTexture.METAL_END_LEG: Vector2i(2, 1),
	LabTileTexture.GOOP_START_TOP: Vector2i(3, 0),
	LabTileTexture.GOOP_MIDDLE_TOP_01: Vector2i(4, 0),
	LabTileTexture.GOOP_MIDDLE_TOP_02: Vector2i(5, 0),
	LabTileTexture.GOOP_END_TOP: Vector2i(6, 0),
	LabTileTexture.WOOD_START_TOP: Vector2i(7, 0),
	LabTileTexture.WOOD_START_LEG: Vector2i(7, 1),
	LabTileTexture.WOOD_MIDDLE_TOP_PLAIN: Vector2i(9, 0),
	LabTileTexture.WOOD_MIDDLE_TOP_OUTLET: Vector2i(8, 0),
	LabTileTexture.WOOD_MIDDLE_TOP_GUM: Vector2i(9, 0),
	LabTileTexture.WOOD_MIDDLE_LEG: Vector2i(8, 1),
	LabTileTexture.WOOD_END_TOP: Vector2i(11,0),
	LabTileTexture.WOOD_END_LEG: Vector2i(11,1)
}

static func get_tile_set(texture: LabTileTexture) -> Vector2i:
	return tileset[texture]
