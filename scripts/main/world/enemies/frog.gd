extends CharacterBody2D

class_name EnemyFrog

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

const FORCE_CONSTANT = 450;
var target: CharacterBody2D
var is_aggressive: bool = false

func _ready() -> void:
	SignalBus.player_died.connect(_deactivate)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if velocity.y == 0:
		velocity.x = lerp(velocity.x, 0.0, 5.0 * delta)
	if is_aggressive and is_on_floor() and timer.is_stopped():
		timer.start()
	move_and_slide()
	_update_sprite()

func _update_sprite() -> void:
	if is_on_floor() and is_aggressive:
		animated_sprite_2d.flip_h = target.global_position.x < global_position.x

	if(velocity.y < 0):
		animated_sprite_2d.play("jump")
	elif(velocity.y > 0):
		animated_sprite_2d.play("fall")
	else:
		animated_sprite_2d.play("idle")

func _launch() -> void:
	if not is_aggressive:
		return
	var difference_position = target.global_position - global_position 
	var direction = difference_position.normalized().clamp(Vector2(-1, -0.5), Vector2(1, -1))
	velocity = direction * FORCE_CONSTANT
	audio_stream_player_2d.play()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		is_aggressive = true
		timer.start()
		target = body

func _on_timer_timeout() -> void:
	_launch()

func _deactivate() -> void:
	is_aggressive = false
