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
	_draw_table(tables.back())

func _process(delta: float) -> void:
	if tables.size() <= 0:
		return
	camera_2d.move_camera(tables.back(), delta)
	if(camera_2d.is_table_in_view(tables.back(), "end")):
		print(tables.size())
		tables.back().change_state()
		_generate()
	elif(camera_2d.is_table_out_view(tables.back())):
		tables.back().change_state()
		_destroy()

func _destroy() -> void:
	var table = tables.front()
	if(table.get_state() != Globals.TableState.COMPLETED):
		return
	for tile in table.get_tiles():
		erase_cell(tile.get_position())
	
	tables.pop_front()
	table.queue_free()

func _generate() -> void:
	if(tables.back().get_state() != Globals.TableState.START):
		return
	tables.back().change_state()
	var table = Table.new(tables.back())
	tables.push_back(table)
	_draw_table(tables.back())

func _draw_table(table: Table) -> void:
	for tile in table.get_tiles():
		set_cell(tile.get_position(), theme, tile.get_atlas_coordinate())
