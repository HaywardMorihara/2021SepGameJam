extends Node2D

const CREATURE_1 = preload("res://game/creatures/Creature1.tscn")
const CREATURE_2 = preload("res://game/creatures/Creature2.tscn")

var num_of_creature_1 : int = 10
var num_of_creature_2 : int = 5
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for n in num_of_creature_1:
		var creature_1_instance : RigidBody2D = CREATURE_1.instance()
		self.add_child(creature_1_instance)
	for n in num_of_creature_2:
		var creature_2_instance : RigidBody2D = CREATURE_2.instance()
		self.add_child(creature_2_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
