class_name LabTileSet

enum Parts { 
	START_TOP,
	MIDDLE_TOP,
	END_TOP,
	START_LEG,
	MIDDLE_LEG,
	END_LEG,
}

enum TableTextures {
	METAL,
	GOOP,
	WOOD,
}

static var tileset = {
	TableTextures.METAL: {
		Parts.START_TOP: [Vector2i(0, 0)],
		Parts.MIDDLE_TOP: [Vector2i(1, 0)],
		Parts.END_TOP: [Vector2i(2, 0)],
		Parts.START_LEG: [Vector2i(0, 1)],
		Parts.END_LEG: [Vector2i(2, 1)],
	},
	TableTextures.GOOP: {
		Parts.START_TOP: [Vector2i(3, 0)],
		Parts.MIDDLE_TOP: [Vector2i(4, 0), Vector2i(5, 0)],
		Parts.END_TOP: [Vector2i(6, 0)],
		Parts.START_LEG: [Vector2i(0, 1)],
		Parts.END_LEG: [Vector2i(2, 1)],
	},
	TableTextures.WOOD: {
		Parts.START_TOP: [Vector2i(7, 0)],
		Parts.MIDDLE_TOP: [Vector2i(8, 0), Vector2i(9, 0), Vector2i(10, 0)],
		Parts.END_TOP: [Vector2i(11, 0)],
		Parts.START_LEG: [Vector2i(7, 1)],
		Parts.MIDDLE_LEG: [Vector2i(8, 1)],
		Parts.END_LEG: [Vector2i(11, 1)],
	},
}

static func get_tiles(texture: TableTextures, part: Parts) -> Array:
	return tileset[texture][part]
