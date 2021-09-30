extends VBoxContainer

var HIGH_SCORE_LINE = preload("res://menu/HighScoreLine.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(SilentWolf.Scores.get_high_scores(10), "sw_scores_received")
	var idx : int = 1
	for score in SilentWolf.Scores.scores:
#		print("Score: %s for player %s" % [score.score, score.player_name])
		var high_score_line = HIGH_SCORE_LINE.instance()
		high_score_line.init(idx, score.player_name, score.score)
		self.add_child(high_score_line)
		idx += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
