extends Area2D

@export var is_enemy_kill_zone = false
@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(_body: Node2D) -> void:
	if _body is Player:
		timer.start()
		audio_stream_player_2d.play()
		_body.get_node("AnimatedSprite2D").flip_v = true
		_body.get_node("CollisionShape2D").queue_free()
		_body.velocity.x = 0
		return
	elif _body is EnemyFrog and not is_enemy_kill_zone:
		_body.queue_free()

func _on_timer_timeout() -> void:
	SignalBus.player_died.emit()
