extends Control
@onready var projectile_guide: CheckBox = $CanvasLayer/VBoxContainer/ProjectileGuide

func _ready() -> void:
	projectile_guide.button_pressed = Globals.has_projectile_guide

func _on_projectile_guide_toggled(toggled_on: bool) -> void:
	Globals.has_projectile_guide = toggled_on

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
