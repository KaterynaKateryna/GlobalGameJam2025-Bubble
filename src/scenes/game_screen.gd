extends Control

var bubble_scene = preload("res://src/objects/Bubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport().get_visible_rect().size

	var step_x = screen_size.x / 3;
	var step_y = screen_size.y / 3;
	for i in range(3):
		for j in range(3):
			var bubble = bubble_scene.instantiate()
			bubble.position = Vector2(step_x * i + step_x / 2, step_y * j + step_y / 2)
			add_child(bubble)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
