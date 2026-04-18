extends Control

@onready var button = get_node("Button")

var button_target = Vector2.ONE
var button_current = Vector2.ONE

@onready var title = get_node("Title")
var sway_timer = 0

func _on_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/World.tscn")

func _process(delta):
	# Title sway
	sway_timer += delta * 2
	title.rotation = sin(sway_timer) * deg_to_rad(5)

	# Smooth scale lerp
	button_current = button_current.lerp(button_target, delta * 10)
	button.scale = button_current


func _on_button_mouse_entered() -> void:
	button_target = Vector2(1.2, 1.2)  # grows


func _on_button_mouse_exited() -> void:
	button_target = Vector2(1.0, 1.0)  # back to normal
