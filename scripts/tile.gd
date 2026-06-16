extends Node

class_name Tile

var position: Vector2i
var atlas_coordinate: Vector2i

func get_atlas_coordinate() -> Vector2i:
	return atlas_coordinate

func get_position() -> Vector2i:
	return position

func _init(new_position: Vector2i, new_atlas_coordinate: Vector2i) -> void:
	position = new_position
	atlas_coordinate = new_atlas_coordinate
