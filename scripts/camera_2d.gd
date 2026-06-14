extends Camera2D
@onready var level_generator: TileMapLayer = %LevelGenerator

const OFFSET = 100;
var camera_speed = 100

func is_table_in_view(table: Table, orientation: String = "start") -> bool:
	var table_point = table.get_start()
	if orientation == "end":
		table_point = table.get_end()
	var end_position = level_generator.map_to_local(table_point)
	var right_bound = get_screen_center_position() + (get_viewport_rect().size / 2)
	return right_bound.x > end_position.x

func is_table_out_view(table: Table, orientation: String = "start") -> bool:
	var table_point = table.get_start()
	if orientation == "end":
		table_point = table.get_end()
	var end_position = level_generator.map_to_local(table_point)
	var left_bound = get_screen_center_position() - (get_viewport_rect().size / 2)
	return left_bound.x > end_position.x

func move_camera(table: Table, delta: float) -> void:
	var start_position = level_generator.map_to_local(table.get_start())
	position.x += (delta * camera_speed)
	if not is_table_in_view(table, "start"):
		return
	position.y = lerp(position.y, start_position.y - OFFSET, 0.4 * delta)
