extends Area2D
@onready var timer: Timer = $Timer

func _on_body_entered(_body: Node2D) -> void:
	if _body is Player:
		timer.start()
		_body.get_node("AnimatedSprite2D").flip_v = true
		_body.get_node("CollisionShape2D").queue_free()
		_body.velocity.x = 0

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
