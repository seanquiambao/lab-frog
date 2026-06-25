extends Control
@onready var rich_text_label: RichTextLabel = $CanvasLayer/RichTextLabel

func _ready() -> void:
	update_score()

func update_score() -> void:
	var score: int = get_parent().get_node("%GameManager").get_points()
	rich_text_label.text = str(score)
