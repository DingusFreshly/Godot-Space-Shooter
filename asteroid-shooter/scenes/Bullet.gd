extends Area3D

@export var speed := 100.0
@export var lifetime := 2.0
@export var damage := 2
func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()


func _physics_process(delta):
	position += -transform.basis.z * speed * delta


func _on_body_entered(body: Node3D) -> void:
	if body is Asteroid:
		print("Shot asteroid")
		body.damage(damage)
