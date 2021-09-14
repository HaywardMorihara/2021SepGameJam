extends Node2D

const CREATURE_1 = preload("res://game/creatures/Creature1.tscn")
const CREATURE_2 = preload("res://game/creatures/Creature2.tscn")

var num_of_creature_1 : int = 10
var num_of_creature_2 : int = 5

enum GameState {PLAYING, WON}
var current_state = GameState.PLAYING

func _ready():
	for n in num_of_creature_1:
		var creature_1_instance = CREATURE_1.instance()
		var damage = 0.0
		creature_1_instance.connect("creature_wall_collision", self, "_handle_creature_wall_collision")
		self.add_child(creature_1_instance)
	for n in num_of_creature_2:
		var creature_2_instance : RigidBody2D = CREATURE_2.instance()
		self.add_child(creature_2_instance)


func _handle_creature_wall_collision(damage):
	$Beaker.apply_damage(damage)

func _process(delta):
	match current_state:
		GameState.PLAYING:
			if $Beaker.health <= 0:
				current_state = GameState.WON
		GameState.WON:
			$Message.visible = true
			$Message.text = "You won!"
