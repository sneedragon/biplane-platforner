extends Camera2D

@export var scroll_speed = 50.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += scroll_speed * delta
