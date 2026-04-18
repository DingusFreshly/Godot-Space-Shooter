class_name World
extends Node3D
const ASTEROID_SPAWN_RATE := 1.0;

var  asteroid_timer := 0.0;

var difficulty = 1.0

const BASE_ASTEROID_COUNT := 10
const ASTEROID_INCREASE_PER_DIFFICULTY := 5

var asteroid_scene := preload("res://scenes/asteroid.tscn")
const SPAWN_RADIUS = 150.0

func _ready() -> void:
	pass # Replace with function body.

func random_vector3(min: float, max: float) -> Vector3:
	return Vector3(
		randf_range(min, max),
		randf_range(min, max),
		randf_range(min, max)
	)   

func spawn() -> void:
	for i in range(BASE_ASTEROID_COUNT + ASTEROID_INCREASE_PER_DIFFICULTY):
		var size = randf_range(4.0, 10.0)
		var dir := (random_vector3(-1.0,1.0) - random_vector3(-1.0,1.0)).normalized()
		var speed := randf_range(20.0, 30.0)
		
		var new := Asteroid.spawn(size, -dir, speed)
		
		new.position = $Player.global_position + random_vector3(-1.0,1.0).normalized() * SPAWN_RADIUS
		$AsteroidSpawn.add_child(new)
		
		print("spawned")
		
		

func _process(delta: float) -> void:
	asteroid_timer += delta
	print(asteroid_timer)
	if asteroid_timer >= ASTEROID_SPAWN_RATE:
		asteroid_timer = 0
		spawn()
