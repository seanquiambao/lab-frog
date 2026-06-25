extends Control

func _on_replay_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
