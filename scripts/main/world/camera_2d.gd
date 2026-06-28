extends Camera2D
@onready var procedural_generation: TileMapLayer = %ProceduralGeneration
@onready var game_manager: Node2D = %GameManager

const OFFSET = 0;
const WEIGHT = 0.3;
const MAX_CAMERA_SPEED = 125;
var camera_speed = 75;

func is_table_in_view(table: Table, orientation: String = "start") -> bool:
	var table_point = table.get_start()
	if orientation == "end":
		table_point = table.get_end()
	var point_position = procedural_generation.map_to_local(table_point)
	var right_bound = get_screen_center_position() + (get_viewport_rect().size / 2)
	return right_bound.x > point_position.x

func is_table_out_view(table: Table, orientation: String = "start") -> bool:
	var table_point = table.get_start()
	if orientation == "end":
		table_point = table.get_end()
	var point_position = procedural_generation.map_to_local(table_point)
	var left_bound = get_screen_center_position() - (get_viewport_rect().size / 2)
	return left_bound.x > point_position.x

func speed_up_camera() -> void:
	camera_speed += (5 * (game_manager.get_points() / 2))

func move_camera(table: Table, delta: float) -> void:
	var start_position = procedural_generation.map_to_local(table.get_start())
	camera_speed = min(camera_speed, MAX_CAMERA_SPEED)
	position.x += (delta * camera_speed)
	if not is_table_in_view(table, "start"):
		return
	position.y = lerp(position.y, start_position.y - OFFSET, WEIGHT * delta)
