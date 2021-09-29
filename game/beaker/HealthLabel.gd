extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	self.text = String(health)

func set_health(health : float):
	self.text = "Wall Health: %s" % String(health)
