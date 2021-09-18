extends Node2D

export var starting_health : float = 100.0

var current_health : float = 100


func _ready():
	pass # Replace with function body.


func _process(delta):
	$HealthLabel.set_health(current_health)

func apply_damage(damage : float):
	current_health -= damage
	if current_health < 0:
		current_health = 0
		
		
func break_the_beaker():
	$RightWall.mode = RigidBody2D.MODE_RIGID
	$LeftWall.mode = RigidBody2D.MODE_RIGID
	$UpperWall.mode = RigidBody2D.MODE_RIGID
	$LowerWall.mode = RigidBody2D.MODE_RIGID
