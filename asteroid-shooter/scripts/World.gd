extends Node3D

@onready var crosshair = get_node("UI/Crosshair")
@onready var player = get_node("Player")

var base_position := Vector2.ZERO
var sensitivity := 40.0  # how far crosshair moves
var base_offset := Vector2(0, 8)

func _ready():
	await get_tree().process_frame
	base_position = crosshair.position

func _process(delta):
	
	var pitch_input = player.pitch_input
	var roll_input = -player.roll_input * 1.5
	var yaw_input = player.yaw_input
	
	var target_offset = Vector2(
		roll_input * sensitivity,
		-pitch_input * sensitivity  # inverted because screen Y goes down
	)

	var target_pos = base_position + base_offset + target_offset

	# smooth movement
	crosshair.position = crosshair.position.lerp(target_pos, delta * 10)
