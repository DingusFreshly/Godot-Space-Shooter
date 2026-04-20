extends RigidBody3D
class_name Asteroid 

@export var direction: Vector3
@export var health: Health
@export var size : float
@export var speed: float

const ASTEROID_SCENE : PackedScene = preload("res://scenes/asteroid.tscn")

var rotation_vec: Vector3

func damage(amount: int):
	health.take_damage(amount)

const EXPLOSION_SCENE := preload("res://scenes/Explosion.tscn")

static func spawn(size: float, direction: Vector3, speed: float) -> Asteroid:
	var asteroid : Asteroid = ASTEROID_SCENE.instantiate()
	asteroid.size = size
	asteroid.direction = direction
	asteroid.speed = speed
	return asteroid
	
func _ready() -> void:
	print(typeof(ASTEROID_SCENE))
	print(ASTEROID_SCENE)
	
	var rand = deg_to_rad(randf_range(-90.0, 90.0))
	rotation_vec = Vector3(rand, rand, rand) 
	
	health = Health.new(size)
	health.died.connect(die)
	
	$Mesh.scale = Vector3.ONE * size
	$Shape.scale = Vector3.ONE * size

func die():
	print("destroyed asteroid")
	var exp := EXPLOSION_SCENE.instantiate()
	exp.global_position = global_position
	exp.get_node("Play").play("explode")
	get_node("../../VFX").add_child(exp)
	queue_free()

func _process(delta: float) -> void:
	global_position += direction * delta * speed
	global_rotation += rotation_vec * delta
	
	var player : CharacterBody3D= get_node("../../Player")
	
	if (global_position - player.global_position).length() > World.SPAWN_RADIUS * 1.5:
		queue_free()
		
func _exit_tree():
	pass
	#print("destroyed")
