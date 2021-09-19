extends Camera2D

# Done following https://kidscancode.org/godot_recipes/2d/screen_shake/

# Started at 0.8
export var decay = 1.0 # How quickly the shaking stops [0, 1].

# Started at 100, 75
export var max_offset = Vector2(5, 10)  # Maximum hor/ver shake in pixels

export var max_roll = 0.05 # Maximum rotation in radians (use sparingly)

# So you can palce an instance of this camera anywhere you like and set the target node it will follow (if we make this node a scene)
#export var (NodePath) var target # Assign the node this camera will follow

var trauma = 0.0 # Current shake strength

var trauma_power = 2 # Trauma exponent. Use [2, 3]

# trauma_power is the relationship between `trauma` and the actual movement of the camera. 
# Square or cube is usually the best


onready var noise = OpenSimplexNoise.new()
var noise_y = 0


func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2
		

# Call to start or increase shaking. Pass it a value from [0,1]
func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)


func _process(delta):
#	if target:
#		# Move the camera to track its target.
#		global_position = get_node(target).global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
		

func shake():
	var amount = pow(trauma, trauma_power)
#	rotation = max_roll * amount * rand_range(-1, 1)
#	offset.x = max_offset.x * amount * rand_range(1, 1)
#	offset.y = max_offset.y * amount * rand_range(-1, 1)
	
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)

