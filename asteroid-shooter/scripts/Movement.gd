extends CharacterBody3D

var max_speed = 50.0
var acceleration = 0.6
var pitch_speed = 1.5
var roll_speed = 1.9
var yaw_speed = 1.25
var input_response = 7.0

@export var forward_speed = 0.0
var vel = Vector3.ZERO
var pitch_input = 0.0
var roll_input = 0.0
var yaw_input = 0.0

@onready var left_thruster = $LeftThruster
@onready var right_thruster = $RightThruster

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
		
	forward_speed = lerp(forward_speed, target, acceleration * delta)
	
func handle_rotation(delta):
	
	pitch_input = lerp(pitch_input, Input.get_action_strength("down") - Input.get_action_strength("up"), input_response * delta)
	roll_input = lerp(roll_input, Input.get_action_strength("left") - Input.get_action_strength("right"), input_response * delta)
	yaw_input = roll_input #lerp(yaw_input, Input.get_action_strength("yaw_right") - Input.get_action_strength("yaw_left"), input_response * delta)

func _physics_process(delta: float):
	
	handle_acceleration(delta)
	handle_rotation(delta)
	
	transform.basis = transform.basis.rotated(transform.basis.z, roll_input * roll_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.y, yaw_input * yaw_speed * delta)
	transform.basis = transform.basis.orthonormalized()
	
	vel = -transform.basis.z * forward_speed
	
	move_and_collide(vel * delta)
