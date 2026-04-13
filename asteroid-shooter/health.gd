extends Node
@export var max_health:int

signal died
signal damaged(amount)
var health := max_health

func take_damage(amount: float):
	health -= amount
	damaged.emit(amount)
	
	if health <= 0:
		died.emit()
