extends Control

var CREATURE_SELECTION_OPTION = preload("res://menu/CreatureSelectionOption.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for creature_scene_name in Global.creatures.keys():
		var creature_selection_option = CREATURE_SELECTION_OPTION.instance()
		creature_selection_option.init(creature_scene_name)
		$VBoxContainer.add_child(creature_selection_option)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	get_tree().change_scene("res://game/Game.tscn")
