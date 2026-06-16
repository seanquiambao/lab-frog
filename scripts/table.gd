extends Node

class_name Table

var start: Vector2i = Vector2i(-2, 2)
var length: int = MIN_LENGTH
var tiles: Array[Tile] = []
var texture: LabTileSet.TableTextures = LabTileSet.TableTextures.METAL

const MIN_DISTANCE = 3
const MAX_DISTANCE = 5
const MIN_LENGTH = 10
const MAX_LENGTH = 15

func get_tiles() -> Array[Tile]:
	return tiles

func get_start() -> Vector2i:
	return start

func get_end() -> Vector2i:
	return Vector2i(start.x + length, start.y)

func _populate_tiles() -> void:
	var end = get_end();
	# Populate top table
	for i in range(start.x, end.x + 1):
		for j in range(start.y, start.y + 10):
			var tile_texture: Vector2i
			var tile_textures: Array
			if i == start.x and j == start.y:
				tile_textures = LabTileSet.get_tiles(texture, LabTileSet.Parts.START_TOP)
			elif i == end.x and j == start.y:
				tile_textures = LabTileSet.get_tiles(texture, LabTileSet.Parts.END_TOP)
			elif j == start.y:
				tile_textures = LabTileSet.get_tiles(texture, LabTileSet.Parts.MIDDLE_TOP)
			elif i == start.x:
				tile_textures = LabTileSet.get_tiles(texture, LabTileSet.Parts.START_LEG)
			elif i == end.x:
				tile_textures = LabTileSet.get_tiles(texture, LabTileSet.Parts.END_LEG)
			elif texture == LabTileSet.TableTextures.WOOD:
				tile_textures = LabTileSet.get_tiles(texture, LabTileSet.Parts.MIDDLE_LEG)
			else:
				continue
			tile_texture = tile_textures[randi_range(0, tile_textures.size() - 1)]
			var tile: Tile = Tile.new(Vector2i(i, j), tile_texture)
			tiles.push_back(tile)

func _clear_tiles() -> void:
	for tile in tiles:
		tile.queue_free()

func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		_clear_tiles()

func _init(recent_table: Table = null) -> void:
	# Spawn
	if not recent_table:
		_populate_tiles()
		return
	# Define positions
	start.x = recent_table.get_end().x + randi_range(MIN_DISTANCE, MAX_DISTANCE)
	start.y = recent_table.get_end().y + ((randi() % 2 if -1 else 1) * randi_range(0, 3))
	length = randi_range(MIN_LENGTH, MAX_LENGTH)
	texture = LabTileSet.TableTextures.values()[randi() % LabTileSet.TableTextures.size()]
	_populate_tiles()
