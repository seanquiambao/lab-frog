extends Node

class_name Tile

enum TileType {
	PLATFORM,
	ENEMY,
}
var position: Vector2i
var tile_type: TileType
var atlas_coordinate

func get_position() -> Vector2i:
	return position

func get_tile_type() -> TileType:
	return tile_type

func get_atlas_coordinate() -> Vector2i:
	return atlas_coordinate

func _init(new_position: Vector2i, new_tile_type: TileType, new_atlas_coordinate = null) -> void:
	position = new_position
	tile_type = new_tile_type
	atlas_coordinate = new_atlas_coordinate
