extends CharacterBody2D
class_name Player

signal jumped
signal died

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var trajectory_line: Line2D = $TrajectoryLine

const FORCE_CONSTANT = 5;
const MAXIMUM_FORCE = 750;
var _mouse_down = false;

func _ready() -> void:
	if SignalBus:
		SignalBus.player_died.connect(_on_player_died)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

	if(velocity.y == 0):
		velocity.x = 0
	
	_update_sprite()
	_detect_input()
	queue_redraw()
	if not _mouse_down or not is_on_floor():
		trajectory_line.clear_points()
	else:
		_draw_projectile(delta)
	

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
		_jump(_calculate_launch())
		_mouse_down = false

func _calculate_launch() -> Vector2:
	var mouse_position = get_global_mouse_position()
	var difference_position = (position - mouse_position)
	var direction = difference_position.normalized()
	var jump_force = clamp(difference_position.length() * FORCE_CONSTANT, 0.0, MAXIMUM_FORCE)
	return jump_force * direction

func _jump(jump_force: Vector2) -> void:
	jumped.emit()
	if not is_on_floor():
		return
	velocity = jump_force

func _draw_projectile(delta: float) -> void:
	var projected_velocity: Vector2 = _calculate_launch()
	_update_trajectory(projected_velocity, get_gravity(), delta)
	
func _update_trajectory(projected_velocity: Vector2, gravity: Vector2, delta: float) -> void:
	if not Globals.has_projectile_guide:
		return
	trajectory_line.clear_points()
	var max_points = 10000;
	var position: Vector2 = Vector2.ZERO
	for i in max_points:
		trajectory_line.add_point(position)
		projected_velocity += (gravity * (delta * 0.01))
		position += (projected_velocity * (delta * 0.01))

func _on_player_died() -> void:
	died.emit()
