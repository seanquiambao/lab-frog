extends TileMapLayer

@onready var camera_2d: Camera2D = $Camera2D
var tables: Array[Table] = []
var theme: ThemeTileSet = ThemeTileSet.Lab

enum ThemeTileSet { Lab = 0 }

func get_tables() -> Array[Table]:
	return tables

func _ready() -> void:
	var table = Table.new()
	tables.push_back(table)
	_draw_tiles(tables.back())

func _process(delta: float) -> void:
	if tables.size() <= 0:
		return
	camera_2d.move_camera(tables.back(), delta)
	if(camera_2d.is_table_in_view(tables.back(), "end")):
		_generate()
	if(camera_2d.is_table_out_view(tables.front(), "end")):
		_destroy()

func _destroy() -> void:
	var table = tables.pop_front()
	for tile in table.get_tiles():
		erase_cell(tile.get_position())
	table.queue_free()
func _generate() -> void:
	var table = Table.new(tables.back())
	tables.push_back(table)
	_draw_tiles(table)

func _draw_tiles(table: Table) -> void:
	for tile in table.get_tiles():
		set_cell(tile.get_position(), theme, tile.get_atlas_coordinate())
