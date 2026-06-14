extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const FORCE_CONSTANT = 5;
const MAXIMUM_FORCE = 500;
var _mouse_down = false;

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if(velocity.y == 0):
		velocity.x = lerp(velocity.x, 0.0, 5.0 * delta)

	_update_sprite()
	_detect_input()
	move_and_slide()
	queue_redraw()

func _draw() -> void:
	if not _mouse_down or not is_on_floor():
		return
	var mouse_position = get_local_mouse_position()
	draw_line(animated_sprite_2d.position, mouse_position, Color.PURPLE, 5.0)

func _update_sprite() -> void:
	if(velocity.x > 0):
		animated_sprite_2d.flip_h = false
	elif(velocity.x < 0):
		animated_sprite_2d.flip_h = true
		
	if(velocity.y < 0):
		animated_sprite_2d.play("jump")
	elif(velocity.y > 0):
		animated_sprite_2d.play("fall")
	else:
		animated_sprite_2d.play("idle")

func _detect_input() -> void:
	if Input.is_action_just_pressed("jump"):
		_mouse_down = true
	if Input.is_action_just_released("jump"):
		_calculate_launch()
		_mouse_down = false

func _calculate_launch() -> void:
	if not is_on_floor():
		return
	var mouse_position = get_global_mouse_position()
	var difference_position = (position - mouse_position)
	var direction = difference_position.normalized()
	var jump_force = clamp(difference_position.length() * FORCE_CONSTANT, 0.0, MAXIMUM_FORCE)
	velocity = direction * jump_force
	
