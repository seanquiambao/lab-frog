extends Node

class_name Tile

var position: Vector2i
var texture: String
var texture_atlas_coordinate: Vector2i

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

func get_atlas_coordinate() -> Vector2i:
	return texture_atlas_coordinate

func get_position() -> Vector2i:
	return position

func _init(new_position: Vector2i, new_texture: String) -> void:
	position = new_position
	texture = new_texture
	texture_atlas_coordinate = ATLAS_COORDINATES[texture]
