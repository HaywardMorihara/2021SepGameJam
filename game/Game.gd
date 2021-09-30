extends Node2D


enum GameState {PLAYING, OVER}
var current_state = GameState.PLAYING


func _ready():
	_reset_game()


func _process(delta):
	match current_state:
		GameState.PLAYING:
			pass
		GameState.OVER:
			_game_over()
	$CanvasLayer/TimerLabel.text = String(stepify($Timer.time_left, 0.01))


func _create_creatures(creature_scene, number : int):
	for n in number:
		var creature_instance = creature_scene.instance()
		creature_instance.connect("creature_wall_collision", self, "_handle_creature_wall_collision")
		creature_instance.add_to_group("creatures")
		self.add_child(creature_instance)


func _stop_game():
	$Timer.paused = true
	$CanvasLayer/Message.visible = true
	$CanvasLayer/RerunButton.show()
	$CanvasLayer/ReselectButton.show()
	$CanvasLayer/MainMenuButton.show()

func _game_over():
	$Beaker.break_the_beaker()
	_stop_game()
	$CanvasLayer/GameOverMenu.show()
	$CanvasLayer/GameOverMenu.init(stepify($Timer.time_left, 0.01))
	

func _reset_game():
	current_state = GameState.PLAYING
	$CanvasLayer/Message.hide()
	$CanvasLayer/RerunButton.hide()
	$CanvasLayer/ReselectButton.hide()
	$CanvasLayer/MainMenuButton.hide()
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
		GameState.OVER:
			pass


func _on_RerunButton_pressed():
	get_tree().reload_current_scene()


func _on_ReselectButton_pressed():
	get_tree().change_scene("res://menu/CreatureSelectionMenu.tscn")


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://menu/MainMenu.tscn")


func _on_Timer_timeout():
	current_state = GameState.OVER
