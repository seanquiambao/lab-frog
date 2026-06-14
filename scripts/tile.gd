extends Node

class_name Tile

var position: Vector2i
var texture: LabTileSet.LabTileTexture
var texture_atlas_coordinate: Vector2i

func get_atlas_coordinate() -> Vector2i:
	return texture_atlas_coordinate

func get_position() -> Vector2i:
	return position

func _init(new_position: Vector2i, new_texture: LabTileSet.LabTileTexture) -> void:
	position = new_position
	texture = new_texture
	texture_atlas_coordinate = LabTileSet.get_tile_set(new_texture)
