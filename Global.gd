extends Node

const MAX_CREATURE_COUNT = 10

var creatures = {
	"CreatureSmall.tscn": {
		"name": "Smol",
		"description": "He smol. Moves fast, but doesn't do much damage.",
		"count": 10
	},
	"CreatureLarge.tscn": {
		"name": "Big Boi",
		"description": "He big. Moves slow, but doesn't does some decent damage.",
		"count": 0
	},
	"CreatureX.tscn": {
		"name": "Sticko",
		"description": "He stick. Which...sometimes causes explosions? It's a feature, not a bug!",
		"count": 0
	}
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
