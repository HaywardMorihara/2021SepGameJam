extends RigidBody2D

signal creature_wall_collision(damage)

# Notes:
# https://godotengine.org/qa/88082/rigidbody-physics-extremily-inconsistent
# https://github.com/godotengine/godot/issues/16113
# It seems like physics aren't entirely reliable all the time...that's not great
# One thing that helps w/ fast-moving objects is "Continuous Collision Detection"
# (which I've turned on), but it comes at a performance cost.
# Might just want to make the objects slower or more bulky for now
# Someone says they prefer Kinematic bodies and implementing their own physics
# with move_and_collide

export var speed : float

var is_start_pos_set : bool = false

var rng = RandomNumberGenerator.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var v : Vector2 = Vector2(0,speed).rotated(randf() * 2.0 * PI)
	self.set_linear_velocity(v)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _integrate_forces(state):
	if not is_start_pos_set:
#		var x_bound : float = get_viewport_rect().size.x
#		var y_bound : float = get_viewport_rect().size.y
		var rand_x : float = rng.randf_range(90.0, 630.0)
		var rand_y : float = rng.randf_range(135.0, 945.0)
#		print("%s, %s" % [rand_x, rand_y])
#		var rand_x_pos : float  = x_bound * rand_x
#		var rand_y_pos : float = y_bound * rand_y
#		print("%s , %s" % [rand_x_pos, rand_y_pos])
		state.transform = Transform2D(0, Vector2(rand_x,rand_y))
		is_start_pos_set = true


func _on_Creature1_body_entered(body):
#	print("Collision: %s" % body)
	emit_signal("creature_wall_collision", 1.0)
