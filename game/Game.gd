extends Node2D

const CREATURE_1 = preload("res://game/creatures/Creature1.tscn")
const CREATURE_2 = preload("res://game/creatures/Creature2.tscn")

var num_of_creature_1 : int = 10
var num_of_creature_2 : int = 5

enum GameState {PLAYING, WON}
var current_state = GameState.PLAYING


func _ready():
	_reset_game()


func _process(delta):
	match current_state:
		GameState.PLAYING:
			if $Beaker.current_health <= 0:
				current_state = GameState.WON
		GameState.WON:
			$Message.visible = true
			$Message.text = "You won!"
			
			
func _input(event):
	match current_state:
		GameState.PLAYING:
			pass
		GameState.WON:
			if event is InputEventMouseButton:
				$Message.hide()
				current_state = GameState.PLAYING
				_reset_game()


func _reset_game():
	current_state = GameState.PLAYING
	$Message.hide()
	$Beaker.current_health = $Beaker.starting_health
	get_tree().call_group("creatures", "queue_free")
	for n in num_of_creature_1:
		var creature_1_instance = CREATURE_1.instance()
		creature_1_instance.add_to_group("creatures")
		creature_1_instance.connect("creature_wall_collision", self, "_handle_creature_wall_collision")
		self.add_child(creature_1_instance)
	for n in num_of_creature_2:
		var creature_2_instance : RigidBody2D = CREATURE_2.instance()
		creature_2_instance.add_to_group("creatures")
		self.add_child(creature_2_instance)
		
		
func _handle_creature_wall_collision(damage):
	match current_state:
		GameState.PLAYING:
			$Beaker.apply_damage(damage)
		GameState.WON:
			pass
