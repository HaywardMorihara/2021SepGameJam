extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_linear_velocity(Vector2(-1000,-1000))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
