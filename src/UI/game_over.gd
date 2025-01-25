extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	GameData.score = 0
	visible = false
	get_tree().change_scene_to_file("res://src/scenes/game_screen.tscn")  # Reload the current scene

func _on_visibility_changed() -> void:
	var tree = get_tree()
	if !tree:
		return

	var viewport = get_viewport()
	var screen_size = viewport.get_visible_rect().size
	var camera = viewport.get_camera_2d()
	if camera:
		var camera_position = camera.get_screen_center_position()
		position.x = camera_position.x - size.x / 2
		position.y = camera_position.y - size.y / 2
		
	if visible:
		get_tree().paused = true
	else:
		get_tree().paused = false
		
