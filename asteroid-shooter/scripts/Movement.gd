extends CharacterBody3D

var max_speed = 50.0
var acceleration = 0.6
var pitch_speed = 1.5
var roll_speed = 1.9
var yaw_speed = 1.25
var input_response = 7.0

var shoot_timer = 0
var shoot_at = 0.05

@export var forward_speed = 0.0
var vel = Vector3.ZERO
var pitch_input = 0.0
var roll_input = 0.0
var yaw_input = 0.0

@onready var left_thruster = $LeftThruster
@onready var right_thruster = $RightThruster

@onready var right_gun_flame = get_node("RightGunFlame")
@onready var left_gun_flame = get_node("LeftGunFlame")

@onready var right_gun = get_node("RightGun")
@onready var left_gun = get_node("LeftGun")
var bullet_tick = 9

@export var bullet_scene: PackedScene

func handle_acceleration(delta):
	
	var target = 0.0
	if Input.is_action_pressed("accelerate"):
		target = max_speed
	
		left_thruster.emitting = true
		right_thruster.emitting = true
		
	else:

		left_thruster.emitting = false
		right_thruster.emitting = false

	forward_speed = lerp(forward_speed, target, acceleration * delta)
	
func handle_rotation(delta):
	
	pitch_input = lerp(pitch_input, Input.get_action_strength("down") - Input.get_action_strength("up"), input_response * delta)
	roll_input = lerp(roll_input, Input.get_action_strength("left") - Input.get_action_strength("right"), input_response * delta)
	yaw_input = roll_input #lerp(yaw_input, Input.get_action_strength("yaw_right") - Input.get_action_strength("yaw_left"), input_response * delta)

func get_shoot_transform(delta):
	var gun: Node3D
	
	if bullet_tick % 2 == 0:
		
		right_gun_flame.emitting = true
		left_gun_flame.emitting = false
		
		gun = right_gun
	else:
		right_gun_flame.emitting = false
		left_gun_flame.emitting = true
		
		
		
		gun = left_gun
	
	var t = gun.global_transform
	
	# Apply slight input-based rotation (optional smoothing)
	t.basis = t.basis.rotated(t.basis.z, roll_input * roll_speed * delta)
	t.basis = t.basis.rotated(t.basis.x, pitch_input * pitch_speed * delta)
	t.basis = t.basis.rotated(t.basis.y, yaw_input * yaw_speed * delta)
	
	return t.orthonormalized()
	
func bullet_handler(delta):
	var bullet = bullet_scene.instantiate()
	bullet_tick += 1
	
	bullet.global_transform = get_shoot_transform(delta)
	
	get_tree().current_scene.add_child(bullet)

func _physics_process(delta: float):
	
	handle_acceleration(delta)
	handle_rotation(delta)
	
	shoot_timer += delta
	
	if Input.is_action_pressed("shoot") and shoot_timer > shoot_at:
		shoot_timer = 0
		bullet_handler(delta)
	
	transform.basis = transform.basis.rotated(transform.basis.z, roll_input * roll_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.y, yaw_input * yaw_speed * delta)
	transform.basis = transform.basis.orthonormalized()
	
	vel = -transform.basis.z * forward_speed
	
	move_and_collide(vel * delta)
