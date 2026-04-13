extends CharacterBody3D

var max_speed = 50.0
var acceleration = 0.6

var forward_speed = 0.0
var vel = Vector3.ZERO

func handle_acceleration(delta):
	
	var target = 0.0
	if Input.is_action_pressed("accelerate"):
		target = max_speed
		
	forward_speed = lerp(forward_speed, target, acceleration * delta)

func _physics_process(delta: float):
	
	handle_acceleration(delta)
	vel = -transform.basis.z * forward_speed
	move_and_collide(vel * delta)
