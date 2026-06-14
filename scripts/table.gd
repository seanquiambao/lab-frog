extends Node

class_name Table

class Tile:
	var position: Vector2i
	var texture: String
	var texture_atlas_coordinate: Vector2i
	
	func get_atlas_coordinate() -> Vector2i:
		return texture_atlas_coordinate

	func get_position() -> Vector2i:
		return position

	func _init(new_position: Vector2i, new_texture: String) -> void:
		position = new_position
		texture = new_texture
		texture_atlas_coordinate = ATLAS_COORDINATES[texture]

var start: Vector2i = Vector2i(-2, 2)
var state: Globals.TableState = Globals.TableState.QUEUED
var length: int = MIN_LENGTH
var tiles: Array[Tile] = []

const MIN_DISTANCE = 3
const MAX_DISTANCE = 5
const MIN_LENGTH = 10
const MAX_LENGTH = 50
const ATLAS_COORDINATES: Dictionary = {
	"METAL_START_TOP": Vector2i(0, 0),
	"METAL_START_LEG": Vector2i(0, 1),
	"METAL_MIDDLE_TOP": Vector2i(1, 0),
	"METAL_END_TOP": Vector2i(2, 0),
	"METAL_END_LEG": Vector2i(2, 1),
	"GOOP_START_TOP": Vector2i(3, 0),
	"GOOP_MIDDLE_TOP_01": Vector2i(4, 0),
	"GOOP_MIDDLE_TOP_02": Vector2i(5, 0),
	"GOOP_END_TOP": Vector2i(6, 0),
	"WOOD_START_TOP": Vector2i(7, 0),
	"WOOD_START_LEG": Vector2i(7, 1),
	"WOOD_MIDDLE_TOP_PLAIN": Vector2i(9, 0),
	"WOOD_MIDDLE_TOP_OUTLET": Vector2i(8, 0),
	"WOOD_MIDDLE_TOP_GUM": Vector2i(9, 0),
	"WOOD_MIDDLE_LEG": Vector2i(8, 1),
	"WOOD_END_TOP": Vector2i(11,0),
	"WOOD_END_LEG": Vector2i(11,1)
}

func get_state() -> Globals.TableState:
	return state

func get_tiles() -> Array[Tile]:
	return tiles

func get_start() -> Vector2i:
	return start

func get_end() -> Vector2i:
	return Vector2i(start.x + length, start.y)

func _set_state(new_state: Globals.TableState) -> void:
	state = new_state

func change_state() -> void:
	
	match get_state():
		Globals.TableState.QUEUED:
			_set_state(Globals.TableState.START)
		Globals.TableState.START:
			_set_state(Globals.TableState.INPROGRESS)
		_:
			_set_state(Globals.TableState.COMPLETED)

func _populate_tiles() -> void:
	for i in range(start.x, get_end().x + 1):
		var texture: String = "METAL_MIDDLE_TOP"
		if(i == start.x):
			texture = "METAL_START_TOP"
		elif(i == get_end().x):
			texture = "METAL_END_TOP"
		var position: Vector2i = Vector2i(i, start.y)
		var tile: Tile = Tile.new(position, texture)
		tiles.push_back(tile)

func _exit_tree() -> void:
	for tile in tiles:
		tile.queue_free()

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
