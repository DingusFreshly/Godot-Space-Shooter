extends RigidBody3D

@export var direction: Vector3
@export var size: float

@export var health: int

signal damaged(amount: int)

func _ready() -> void:
	$Mesh.scale = $Shape.scale
	$Mesh.position = $Shape.position


func _process(delta: float) -> void:
	global_position += direction * delta
	
	
