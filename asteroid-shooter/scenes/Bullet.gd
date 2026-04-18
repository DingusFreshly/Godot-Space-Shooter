extends Area3D

@export var speed := 150.0
@export var lifetime := 2.0   # seconds

func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	position += -transform.basis.z * speed * delta
