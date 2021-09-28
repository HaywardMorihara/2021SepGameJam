extends Node2D


enum GameState {PLAYING, WON, LOST}
var current_state = GameState.PLAYING


func _ready():
	_reset_game()


func _process(delta):
	match current_state:
		GameState.PLAYING:
			if $Beaker.current_health <= 0:
				current_state = GameState.WON
		GameState.WON:
			_win()
		GameState.LOST:
			_lose()
	$TimerLabel.text = String(stepify($Timer.time_left, 0.01))


func _create_creatures(creature_scene, number : int):
	for n in number:
		var creature_instance = creature_scene.instance()
		creature_instance.connect("creature_wall_collision", self, "_handle_creature_wall_collision")
		creature_instance.add_to_group("creatures")
		self.add_child(creature_instance)


func _stop_game():
	$Timer.paused = true
	$Message.visible = true
	$RerunButton.show()
	$ReselectButton.show()
	$MainMenuButton.show()

func _win():
	$Beaker.break_the_beaker()
	$Message.text = "You won!"
	_stop_game()
	$GameOverMenu.show()
	$GameOverMenu.init(stepify($Timer.time_left, 0.01))
	

func _lose():
	$Message.text = "You lose!"
	_stop_game()


func _reset_game():
	current_state = GameState.PLAYING
	$Message.hide()
	$RerunButton.hide()
	$ReselectButton.hide()
	$MainMenuButton.hide()
	$Beaker.current_health = $Beaker.starting_health
	get_tree().call_group("creatures", "queue_free")
	for creature_scene_name in Global.creatures.keys():
		var creature_scene = load("res://game/creatures/%s" % creature_scene_name)
		var creature_count = Global.creatures.get(creature_scene_name).get("count")
		_create_creatures(creature_scene, creature_count)
	$Timer.start()
		
		
func _handle_creature_wall_collision(damage):
	match current_state:
		GameState.PLAYING:
			$Beaker.apply_damage(damage)
			$ShakeCamera2D.add_trauma(0.1)
		GameState.WON:
			pass
		GameState.LOST:
			pass


func _on_RerunButton_pressed():
	get_tree().reload_current_scene()


func _on_ReselectButton_pressed():
	get_tree().change_scene("res://menu/CreatureSelectionMenu.tscn")


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://menu/MainMenu.tscn")


func _on_Timer_timeout():
	current_state = GameState.LOST
