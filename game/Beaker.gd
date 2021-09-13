extends Node2D

export var health : float = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.get_node("HealthLabel").set_health(health)

func apply_damage(damage : float):
	health -= damage

func _on_Wall_body_entered(body):
	print(body)
