extends Node2D

var points: int = 0

func add_points(addition: int) -> void:
	points += addition
	print(get_points())

func get_points() -> int:
	return points
