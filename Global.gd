extends Node

const MAX_CREATURE_COUNT = 10

var creatures = {
	"CreatureSmall.tscn": {
		"name": "Smol",
		"description": "He smol. Moves fast, but doesn't do much damage.",
		"count": 10,
		"sprite_name": "creature_small.png",
		"sprite_x": 16,
		"sprite_y": 16
	},
	"CreatureLarge.tscn": {
		"name": "Big Boi",
		"description": "He big. Moves slow, but doesn't does some decent damage.",
		"count": 0,
		"sprite_name": "creature_large.png",
		"sprite_x": 32,
		"sprite_y": 32
	},
	"CreatureX.tscn": {
		"name": "Sticko",
		"description": "He stick. Which...sometimes causes explosions? It's a feature, not a bug!",
		"count": 0,
		"sprite_name": "creature_x.png",
		"sprite_x": 16,
		"sprite_y": 32
	}
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
