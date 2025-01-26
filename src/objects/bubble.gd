extends StaticBody2D

@onready var modifier_label = get_node("ModifierLabel")
@onready var sprite = get_node("Sprite2D")

var previous_position: Vector2
var velocity: Vector2 = Vector2.ZERO

var modifier = null

var bound_value = 50

var bounds_left
var bounds_right
var bounds_top
var bounds_bottom

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if modifier:
		modifier_label.text = modifier
		
	previous_position = position
		
	var center_x = position.x
	var center_y = position.y
	
	bounds_left = center_x - bound_value
	bounds_right = center_x + bound_value
	bounds_top = center_y - bound_value
	bounds_bottom = center_y + bound_value
	
	_move_to_random_position()
	
func _move_to_random_position():
	var random_x = randf_range(bounds_left, bounds_right)
	var random_y = randf_range(bounds_top, bounds_bottom)
	var target_position = Vector2(random_x, random_y)
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_position, 3.0)
	
	# Call this again once the movement is complete
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished():
	_move_to_random_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate velocity by comparing the position change
	var delta_position = position - previous_position
	velocity = delta_position / delta  # Velocity = distance / time (frame time)

	# Update previous_position for next frame
	previous_position = position
	
func get_modifier():
	if modifier:
		return modifier
	return "+1"
