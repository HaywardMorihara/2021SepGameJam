extends Control

var CREATURE_SELECTION_OPTION = preload("res://menu/CreatureSelectionOption.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for creature_scene_name in Global.creatures.keys():
		var creature_selection_option = CREATURE_SELECTION_OPTION.instance()
		creature_selection_option.init(creature_scene_name)
		$CreatureSection.add_child(creature_selection_option)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_creature_count = 0
	for creature_info in Global.creatures.values():
		current_creature_count += creature_info.get("count")
	$TitleSection/CreaturesLeftLabel.text = "You can pick %s more creatures:" % String(Global.MAX_CREATURE_COUNT - current_creature_count)


func _on_StartButton_pressed():
	get_tree().change_scene("res://game/Game.tscn")
