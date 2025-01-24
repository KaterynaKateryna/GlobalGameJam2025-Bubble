extends Control

var bubble_scene = preload("res://src/objects/Bubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	
	var min_x = 0
	var max_x = screen_size.x
	var min_y = 0
	var max_y = screen_size.y

	for i in range(10):
		var bubble = bubble_scene.instantiate()
		var random_position = Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))
		bubble.position = random_position
		add_child(bubble)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
