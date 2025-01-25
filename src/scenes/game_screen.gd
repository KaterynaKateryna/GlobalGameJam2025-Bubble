extends Control

var bubble_scene = preload("res://src/objects/bubble.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var camera = get_viewport().get_camera_2d()

	var step_x = 320;
	var step_y = 320;
	for i in range(3):
		var y = camera.global_position.y - i * step_y - 180;
		_create_bubble(camera.global_position.x, y, _get_random_modifier())  
		_create_bubble(camera.global_position.x - step_x, y, _get_random_modifier())
		_create_bubble(camera.global_position.x + step_x, y, _get_random_modifier())
			
			
func _create_bubble(x: float, y: float, modifier):
	var bubble = bubble_scene.instantiate()
	bubble.position = Vector2(x, y)
	bubble.modifier = modifier
	add_child(bubble)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _get_random_modifier():
	var rand = rng.randf_range(0, 1)
	
	if rand < 0.5:
		return null
		
	var modifier
	var rand_modifier = rng.randi_range(0, 3)
	if rand_modifier == 0:
		modifier = "+10"
	elif rand_modifier == 1:
		modifier = "-20"
	elif rand_modifier == 2:
		modifier = "x20"
	elif rand_modifier == 3:
		modifier = "%2"
	return modifier
	
