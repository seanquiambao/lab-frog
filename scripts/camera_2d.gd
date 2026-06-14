extends Camera2D
@onready var level_generator: TileMapLayer = %LevelGenerator

var camera_speed = 100

func is_table_in_view(table: Table) -> bool:
	var end_position = level_generator.map_to_local(table.get_end())
	var right_bound = get_screen_center_position() + (get_viewport_rect().size / 2)
	return right_bound.x > end_position.x

func is_table_out_view(table: Table) -> bool:
	var end_position = level_generator.map_to_local(table.get_end())
	var left_bound = get_screen_center_position() - (get_viewport_rect().size / 2)
	return left_bound.x > end_position.x

func _follow_tables() -> void:
	pass

func _process(delta: float) -> void:
	position.x += (camera_speed * delta)
