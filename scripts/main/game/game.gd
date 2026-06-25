extends Node2D

@export var spawn_point: Vector2i
@export var game_over_screen: CanvasLayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

enum GameState {
	START,
	PLAYING,
	END
}

var player: CharacterBody2D
var procedural_generation: TileMapLayer
var state: GameState = GameState.START

func get_game_state() -> GameState:
	return state

func set_game_state(game_state: GameState) -> void:
	state = game_state

func _on_player_jumped() -> void:
	if state != GameState.START:
		return
	set_game_state(GameState.PLAYING)

func _on_player_died() -> void:
	audio_stream_player_2d.play()
	set_game_state(GameState.END)
	game_over_screen.visible = true
