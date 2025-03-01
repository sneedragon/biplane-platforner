extends CharacterBody2D

const SPEED = 200.0

@onready var player = get_node("../Player")
@onready var camera = get_node("../Camera2D")

func _physics_process(delta):
	# Get input for movement
	if player.is_hidden:
		var direction_x = Input.get_axis("player_left", "player_right")
		var direction_y = Input.get_axis("player_up", "player_down")
	
	# Set velocity based on input
		velocity.x = direction_x * SPEED
		velocity.y = direction_y * SPEED

	
	elif not is_on_floor():
		velocity.y = 5
		velocity.x = 1 * camera.scroll_speed
	
	else:
		velocity.x = 0
		velocity.y = 0
		

	move_and_slide()
	# Move and slide (enables collision with Mario)
