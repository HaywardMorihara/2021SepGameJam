extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Wiping the leaderboard: https://silentwolf.com/leaderboard 'Wiping your Leaderboard'
	SilentWolf.Scores.wipe_leaderboard()
	
	for i in 10:
		var score_id = yield(SilentWolf.Scores.persist_score(
			"TBD", 0.00),
			"sw_score_posted")
		print("Submitted %s" % score_id)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
