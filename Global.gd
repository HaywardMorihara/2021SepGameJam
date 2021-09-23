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
	var api_key_file = File.new()
	api_key_file.open("res://api_key.env", File.READ)
	var api_key = api_key_file.get_line()
	api_key_file.close()
	
	# https://cyberglads.com/making-cyberglads-8-leaderboard.html
	# https://escada-games.itch.io/jump3match/devlog/242610/making-a-simple-online-leaderboard-in-godot-with-silentwolf
	# https://silentwolf.com/
	SilentWolf.configure({
		"api_key": api_key,
		"game_id": "2021SepGameJam",
		"game_version": "1.0",
		"log_level": 1
	})

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
