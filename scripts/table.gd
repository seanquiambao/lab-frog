extends Node

class_name Table

var start: Vector2i = Vector2i(-2, 2)
var length: int = MIN_LENGTH
var tiles: Array[Tile] = []

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
	# Populate top table
	for i in range(start.x, get_end().x + 1):
		var texture: String = "METAL_MIDDLE_TOP"
		if(i == start.x):
			texture = "METAL_START_TOP"
		elif(i == get_end().x):
			texture = "METAL_END_TOP"
		var position: Vector2i = Vector2i(i, start.y)
		var tile: Tile = Tile.new(position, texture)
		tiles.push_back(tile)
	
	# Populate legs
	for i in range(start.y + 1, start.y + 10):
		var start_position: Vector2i = Vector2i(start.x, i)
		var end_position: Vector2i = Vector2i(get_end().x, i)
		var start_tile: Tile = Tile.new(start_position, "METAL_START_LEG")
		var end_tile: Tile = Tile.new(end_position, "METAL_END_LEG")
		tiles.push_back(start_tile)
		tiles.push_back(end_tile)

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
	_populate_tiles()
