extends Control


var score : float


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init(score : float):
	self.score = score
	$VBoxContainer/ScoreLabel.text = String(score)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SubmitButton_pressed():
	if $VBoxContainer/LineEdit.text != '':
		var score_id = yield(SilentWolf.Scores.persist_score(
			$VBoxContainer/LineEdit.text, self.score),
			"sw_score_posted")
		print(score_id)
