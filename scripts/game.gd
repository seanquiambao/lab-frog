extends Node2D

var player_resource = preload("res://scenes/player.tscn")

@export var spawn: Vector2 = Vector2(112, 60)

func _ready() -> void:
	var player = player_resource.instantiate()
	add_child(player)
	player.global_position = spawn
