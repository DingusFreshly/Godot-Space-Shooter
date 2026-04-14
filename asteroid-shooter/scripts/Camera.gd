extends Camera3D

@onready var target = get_parent().get_node("Player")
var follow_speed := 5.0
var offset := Vector3(0, 4.5, 15)

func _process(delta):
	if target:
		
		var desired_position = target.global_transform.origin + target.global_transform.basis * offset
	
		global_position = global_position.lerp(desired_position, follow_speed * delta)
		global_transform.basis = global_transform.basis.slerp(target.global_transform.basis, follow_speed * delta)
