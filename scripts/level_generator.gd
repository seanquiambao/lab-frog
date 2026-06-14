extends TileMapLayer
@onready var camera_2d: Camera2D = $Camera2D

var tables: Array[Table] = []
var theme: ThemeTileSet = ThemeTileSet.Lab
enum ThemeTileSet { Lab = 0 }

func _ready() -> void:
	var table = Table.new()
	tables.push_back(table)
	_draw_table(tables.back())

func _destroy() -> void:
	pass

func _generate() -> void:
	pass

func _draw_table(table: Table) -> void:
	for tile in table.get_tiles():
		
		print(tile.get_position())
		set_cell(tile.get_position(), theme, tile.get_atlas_coordinate())
