extends StaticBody2D

var previous_position: Vector2
var velocity: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize previous_position
	previous_position = position
	
	var tween = get_tree().create_tween()

	# Animate the position from current position to end_position over 3 seconds
	tween.tween_property(self, "position", Vector2(position.x + 100, position.y), 3)
	tween.chain().tween_property(self, "position", Vector2(position.x - 100, position.y), 3)
	tween.set_loops()

func _process(delta):
	# Calculate velocity by comparing the position change
	var delta_position = position - previous_position
	velocity = delta_position / delta  # Velocity = distance / time (frame time)

	# Update previous_position for next frame
	previous_position = position
