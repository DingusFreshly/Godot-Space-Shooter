extends Area3D


func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	position += -transform.basis.z * speed * delta
