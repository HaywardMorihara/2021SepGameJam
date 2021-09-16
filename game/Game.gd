extends Node2D

const CREATURE_SMALL = preload("res://game/creatures/CreatureSmall.tscn")
const CREATURE_LARGE = preload("res://game/creatures/CreatureLarge.tscn")
const CREATURE_X = preload("res://game/creatures/CreatureX.tscn")

var num_of_creature_small : int = 5
var num_of_creature_large : int = 5
var num_of_creature_x : int = 5

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


func _create_creatures(creature_scene, number : int):
	for n in number:
		var creature_instance = creature_scene.instance()
		creature_instance.connect("creature_wall_collision", self, "_handle_creature_wall_collision")
		creature_instance.add_to_group("creatures")
		self.add_child(creature_instance)


func _reset_game():
	current_state = GameState.PLAYING
	$Message.hide()
	$Beaker.current_health = $Beaker.starting_health
	get_tree().call_group("creatures", "queue_free")
	_create_creatures(CREATURE_SMALL, num_of_creature_small)		
	_create_creatures(CREATURE_LARGE, num_of_creature_large)
	_create_creatures(CREATURE_X, num_of_creature_x)
		
		
func _handle_creature_wall_collision(damage):
	match current_state:
		GameState.PLAYING:
			$Beaker.apply_damage(damage)
		GameState.WON:
			pass
