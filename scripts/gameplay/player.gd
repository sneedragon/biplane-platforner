extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0  # Default gravity in pixels/second²

var is_hidden = false
@onready var plane = get_node("../Plane")

func _physics_process(delta):
	# Handle reappearing when pressing jump
	if Input.is_action_just_pressed("player_jump") and is_hidden:
		show_character()
		
	# Skip physics if hidden
	if is_hidden:
		return
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Horizontal movement
	var direction = Input.get_axis("player_left", "player_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, (0.5 * SPEED))
	
	# Jumping
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Move and slide (handles collision and moving platforms)
	move_and_slide()

func hide_character():
	is_hidden = true
	hide()  # Hides the sprite
	set_collision_layer_value(1, false)  # Disable collision
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, false)
	velocity = Vector2.ZERO  # Stop movement

func show_character():
	is_hidden = false
	show()  # Shows the sprite
	position.x = get_node("../Plane").position.x
	position.y = get_node("../Plane").position.y + -32
	set_collision_layer_value(1, true)  # Re-enable collision
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, true)

func _on_area_2d_2_area_entered(area: Area2D) -> void:
	hide_character()
	
