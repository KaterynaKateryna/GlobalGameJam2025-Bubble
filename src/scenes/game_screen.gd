extends Control

var bubble_scene = preload("res://src/objects/bubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	var middle_x = screen_size.x / 2;
	var step_x = 350;
	var step_y = 350;
	for i in range(3):
		var y = screen_size.y - i * step_y - 350;
		_create_bubble(middle_x, y)
		_create_bubble(middle_x - step_x, y)
		_create_bubble(middle_x + step_x, y)
			
			
func _create_bubble(x: float, y: float):
	var bubble = bubble_scene.instantiate()
	bubble.position = Vector2(x, y)
	add_child(bubble)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
