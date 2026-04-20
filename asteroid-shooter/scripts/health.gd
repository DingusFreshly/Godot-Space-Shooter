class_name Health
extends Node
@export var max_health:int

signal died
signal damaged(amount)
var health := max_health

func take_damage(amount: int):
	health -= amount
	damaged.emit(amount)
	
	if health <= 0:
		died.emit()

func _init(max: int):
	max_health = max
