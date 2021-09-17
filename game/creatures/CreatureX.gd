extends "res://game/creatures/CreatureBase.gd"

# For some reason, each body has an initial collision. Haven't figured out why
var num_of_collision = -1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
##	._ready()
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CreatureX_body_entered(body):
	if body.is_in_group("creatures"):
		if num_of_collision >= 0:
			# TODO My guess is that this needs to go up a level or something
			var pj = PinJoint2D.new()
			pj.set_node_a(body.get_path())
			pj.set_node_b(self.get_path())
			add_child(pj)
		num_of_collision += 1
