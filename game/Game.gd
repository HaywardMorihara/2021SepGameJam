extends Node2D

const CREATURE_SMALL = preload("res://game/creatures/CreatureSmall.tscn")
const CREATURE_LARGE = preload("res://game/creatures/CreatureLarge.tscn")

var num_of_creature_small : int = 10
var num_of_creature_large : int = 5

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
	for n in num_of_creature_small:
		var creature_instance : RigidBody2D = CREATURE_SMALL.instance()
		creature_instance.add_to_group("creatures")
		self.add_child(creature_instance)
	for n in num_of_creature_large:
		var creature_instance : RigidBody2D = CREATURE_LARGE.instance()
		creature_instance.add_to_group("creatures")
		self.add_child(creature_instance)
		
		
func _handle_creature_wall_collision(damage):
	match current_state:
		GameState.PLAYING:
			$Beaker.apply_damage(damage)
		GameState.WON:
			pass
