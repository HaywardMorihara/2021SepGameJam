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


func _win():
	$Message.visible = true
	$Message.text = "You won!"
	$RetryButton.show()
	$ReselectButton.show()
	$MainMenuButton.show()
	

func _lose():
	$Message.visible = true
	$Message.text = "You lose!"
	$RetryButton.show()
	$ReselectButton.show()
	$MainMenuButton.show()


func _reset_game():
	current_state = GameState.PLAYING
	$Message.hide()
	$RetryButton.hide()
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
		GameState.WON:
			pass
		GameState.LOST:
			pass


func _on_RetryButton_pressed():
	get_tree().reload_current_scene()


func _on_ReselectButton_pressed():
	get_tree().change_scene("res://menu/CreatureSelectionMenu.tscn")


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://menu/MainMenu.tscn")


func _on_Timer_timeout():
	current_state = GameState.LOST
