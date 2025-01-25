extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Get the camera's position	
	var viewport = get_viewport()
	var screen_size = viewport.get_visible_rect().size
	var camera = viewport.get_camera_2d()
	var center = camera.get_screen_center_position()
	if camera:
		position.x = center.x - size.x / 2
		position.y = center.y - size.y / 2
