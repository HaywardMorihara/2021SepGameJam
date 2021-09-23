extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(SilentWolf.Scores.get_high_scores(10), "sw_scores_received")
	print(SilentWolf.Scores.scores)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	get_tree().change_scene("res://menu/CreatureSelectionMenu.tscn")
