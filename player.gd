extends CharacterBody2D

# Declare a variable 'speed' to control the movement speed of the character in pixels per second.
# This value can be adjusted to make the character move faster or slower.
var speed = 100

# Declare a variable 'last_direction' to keep track of the last direction of movement.
# This is used to determine which idle animation to play when the character stops moving.
var last_direction = Vector2.ZERO

# Declare a variable 'animated_sprite' to reference the AnimatedSprite2D node.
# This will allow us to control the character's animations.
var animated_sprite

# The _ready function is called when the node is added to the scene.
# It's a good place to initialize variables and set up references to other nodes.
func _ready():
	# Assign the AnimatedSprite2D node to the 'animated_sprite' variable.
	# This allows us to control the animations of the character.
	animated_sprite = $AnimatedSprite2D

# The _physics_process function is called every physics frame (typically 60 times per second).
# This is where we handle movement and other physics-related logic.
func _physics_process(delta):
	# Get the direction of movement based on the arrow keys pressed.
	# The direction is represented as a Vector2, where:
	# - X is -1 if "left" is pressed, 1 if "right" is pressed, and 0 otherwise.
	# - Y is -1 if "up" is pressed, 1 if "down" is pressed, and 0 otherwise.
	# This allows us to determine which direction the player wants the character to move.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Calculate the velocity by multiplying the direction by the speed.
	# The velocity determines how fast and in which direction the character will move.
	# This ensures that the character moves at a consistent speed in any direction.
	velocity = direction * speed

	# If the character is moving (direction is not zero), update the last_direction variable.
	# This helps us remember the last direction the character was moving, even after they stop.
	if direction != Vector2.ZERO:
		last_direction = direction

	# Determine the walking animation to play based on the direction.
	# Play the right walking animation if moving left or right.
	# Play the up walking animation if moving up.
	# Play the down walking animation if moving down.
	# This ensures that the character's appearance matches the direction of movement.
	if direction.x != 0:
		animated_sprite.play("walk_right")
	elif direction.y < 0:
		animated_sprite.play("walk_up")
	elif direction.y > 0:
		animated_sprite.play("walk_down")
	else:
		# If the character is not moving, play the idle animation based on the last direction of movement.
		# Play the right idle animation if the last movement was left or right.
		# Play the up idle animation if the last movement was up.
		# Play the down idle animation if the last movement was down.
		# This gives the character a natural appearance when they stop moving.
		if last_direction.x != 0:
			animated_sprite.play("idle_right")
		elif last_direction.y < 0:
			animated_sprite.play("idle_up")
		elif last_direction.y > 0:
			animated_sprite.play("idle_down")

	# Flip the sprite horizontally if the last x direction was left.
	# This allows us to use the same animation for both left and right directions.
	# It's a clever way to save memory and reduce the number of animations needed.
	animated_sprite.flip_h = last_direction.x < 0

	# Move the character using the calculated velocity.
	# The move_and_slide method handles collisions and slides the character along obstacles if necessary.
	# This ensures smooth movement and prevents the character from getting stuck in walls or other objects.
	move_and_slide()
