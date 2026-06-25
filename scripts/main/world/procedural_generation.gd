extends TileMapLayer
@export var game: Node2D
@onready var camera_2d: Camera2D = $Camera2D

var _coin_resource = preload("res://scenes/main/coin.tscn")
var _enemy_resource = preload("res://scenes/main/enemy_frog.tscn")
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
	if game.get_game_state() == game.GameState.PLAYING:
		camera_2d.move_camera(tables.back(), delta)
	if(camera_2d.is_table_in_view(tables.back(), "end")):
		_generate()
	if(camera_2d.is_table_out_view(tables.front(), "end")):
		_destroy()

func _generate() -> void:
	var table = Table.new(tables.back())
	tables.push_back(table)
	_draw_tiles(table)

func _destroy() -> void:
	var table = tables.pop_front()
	for tile in table.get_tiles():
		erase_cell(tile.get_position())
	table.queue_free()

func _draw_tiles(table: Table) -> void:
	for tile in table.get_tiles():
		match(tile.get_tile_type()):
			Tile.TileType.PLATFORM:
				set_cell(tile.get_position(), theme, tile.get_atlas_coordinate())
			Tile.TileType.ENEMY:
				var enemy = _enemy_resource.instantiate()
				get_parent().add_child(enemy)
				enemy.global_position = map_to_local(tile.get_position())
			Tile.TileType.COIN:
				var coin = _coin_resource.instantiate()
				get_parent().add_child(coin)
				coin.global_position = map_to_local(tile.get_position())
			_:
				pass
