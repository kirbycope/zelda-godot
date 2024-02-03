# Extending the CharacterBody2D class to create a custom enemy character
extends CharacterBody2D

# Declare variables for movement speed, last direction, animated sprite, and direction change timer
var speed = 50
var last_direction = Vector2.ZERO
var animated_sprite
var direction_change_timer = 0
var direction_change_interval = 2 # seconds

# Define the boundaries of the area where the magpie can fly (in pixels)
var min_position = Vector2(0, 0)
var max_position = Vector2(4096, 1408)

# _ready function is called when the node is added to the scene
# For arduino fans, think of the _ready function like ‘void setup’
func _ready():
	animated_sprite = $AnimatedSprite2D # Reference to the AnimatedSprite2D node
	pick_random_direction() # Pick an initial random direction for the enemy

# _physics_process function is called every physics frame (typically 60 times per second)
# For arduino fans, think of the _physics_process function like ‘void loop’
func _physics_process(delta):
	direction_change_timer += delta # Increment the timer by the time since the last frame
	if direction_change_timer >= direction_change_interval:
		pick_random_direction() # Pick a new random direction every 5 seconds
		direction_change_timer = 0

	velocity = last_direction * speed # Calculate the velocity based on the direction and speed

	# Reset flips for the sprite
	animated_sprite.flip_h = false
	animated_sprite.flip_v = false

	# Determine the animation to play based on the direction
	if last_direction.x != 0:
		animated_sprite.play("walk_left")
		animated_sprite.flip_h = last_direction.x > 0 # Flip horizontally if moving left
	elif last_direction.y > 0:
		animated_sprite.play("walk_down")
	elif last_direction.y < 0:
		animated_sprite.play("walk_down")
		animated_sprite.flip_v = true # Flip vertically if moving down

	move_and_slide() # Move the character using the calculated velocity

	# Check if the position has been clamped to a boundary
	var old_position = position
	position.x = clamp(position.x, min_position.x, max_position.x)
	position.y = clamp(position.y, min_position.y, max_position.y)

	if old_position != position:
		# Reverse the direction by 180 degrees if the enemy hits a boundary
		last_direction = -last_direction

# Function to pick a random direction for the enemy
func pick_random_direction():
	var new_direction = Vector2.ZERO
	# Ensure that the direction is never a zero vector
	while new_direction == Vector2.ZERO:
		new_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	new_direction = new_direction.normalized()
	last_direction = new_direction # Update the last_direction variable with the new direction
