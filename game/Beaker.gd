extends Node2D

export var starting_health : float = 100.0

var current_health : float = 100


func _ready():
	pass # Replace with function body.


func _process(delta):
	$HealthLabel.set_health(current_health)

func apply_damage(damage : float):
	current_health -= damage
