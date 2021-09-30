extends Node2D


var current_damage : float


func _ready():
	pass
	
	
func _process(delta):
	$DamageLabel.set_damage(current_damage)

func apply_damage(damage : float):
	current_damage += damage
	if current_damage < 0:
		current_damage = 0
		
		
func break_the_beaker():
	$RightWall.mode = RigidBody2D.MODE_RIGID
	$LeftWall.mode = RigidBody2D.MODE_RIGID
	$UpperWall.mode = RigidBody2D.MODE_RIGID
	$LowerWall.mode = RigidBody2D.MODE_RIGID
