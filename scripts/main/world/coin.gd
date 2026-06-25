extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	get_parent().get_node("%GameManager").add_points(1)
	get_parent().get_node("%ScoreCount").update_score()
	get_parent().get_node("%Camera2D").speed_up_camera()
	queue_free()
