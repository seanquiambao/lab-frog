extends Control
@onready var projectile_guide: CheckBox = $CanvasLayer/VBoxContainer/ProjectileGuide
@onready var music: HSlider = $CanvasLayer/VBoxContainer/Music/Music
@onready var sfx: HSlider = $CanvasLayer/VBoxContainer/SFX/SFX
@onready var music_audio: AudioStreamPlayer = $MusicAudio
@onready var sfx_audio: AudioStreamPlayer = $SFXAudio

var sfx_bus_index 
var music_bus_index 

func _ready() -> void:
	projectile_guide.button_pressed = Globals.has_projectile_guide
	sfx_bus_index = AudioServer.get_bus_index("SFX")
	music_bus_index = AudioServer.get_bus_index("Music")
	sfx.value = db_to_linear(AudioServer.get_bus_volume_linear(sfx_bus_index))
	music.value = db_to_linear(AudioServer.get_bus_volume_linear(music_bus_index))

func _on_projectile_guide_toggled(toggled_on: bool) -> void:
	Globals.has_projectile_guide = toggled_on

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")

func _on_sfx_value_changed(value: float) -> void:
	music_audio.stop()
	AudioServer.set_bus_volume_linear(sfx_bus_index, value)
	sfx_audio.play()

func _on_music_value_changed(value: float) -> void:
	sfx_audio.stop()
	AudioServer.set_bus_volume_linear(music_bus_index, value)
	music_audio.play()
