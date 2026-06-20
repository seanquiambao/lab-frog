extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	get_parent().get_node("%GameManager").add_points(1)
	queue_free()
