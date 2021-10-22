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

var DAMAGE_TEXT_SCENE = preload("res://game/DamageText.tscn")
var WALL_PARTICLES_SCENE = preload("res://game/particles/WallParticles.tscn")

var is_start_pos_set : bool = false

var rng = RandomNumberGenerator.new()

var local_collision_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var v : Vector2 = Vector2(0,speed).rotated(randf() * 2.0 * PI)
	self.set_linear_velocity(v)
#	print("set velocity %s" % String(v))


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
	if(state.get_contact_count() >= 1):  #this check is needed or it will throw errors 
		local_collision_pos = state.get_contact_local_position(0)

func _on_Creature_body_entered(body):
	_collision_animation()
	if body.is_in_group("creatures"):
		$CreatureBumpAudioStreamPlayer2D.play()
	if body.is_in_group("walls"):
		$WallBumpAudioStreamPlayer2D.play()
		var damage : float = self.mass * self.mass * self.mass * self.linear_velocity.length() / 1000
#		print("Damage: %s from creature %s" % [String(damage), self.get_filename()])
		emit_signal("creature_wall_collision", damage)
		
		var damage_text = DAMAGE_TEXT_SCENE.instance()
		damage_text.text = String(stepify(damage, 0.01))
		damage_text.rect_global_position = self.global_position + Vector2(0, -50.0)
		get_tree().get_root().add_child(damage_text)
		damage_text.start_timer()
		
		var wall_particles = WALL_PARTICLES_SCENE.instance()
		wall_particles.position = local_collision_pos
		wall_particles.emitting = true
		get_tree().get_root().add_child(wall_particles)
		# TODO Destroy on completion


func _collision_animation():
	$AnimatedSprite.frame = 1
	$AnimatedSprite/CollisionAnimationTimer.start()
	

func _on_CollisionAnimationTimer_timeout():
	$AnimatedSprite.frame = 0
