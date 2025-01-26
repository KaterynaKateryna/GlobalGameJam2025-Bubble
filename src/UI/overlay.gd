extends Control

@onready var label = get_node("Label")
@onready var try = get_node("Try again")
@onready var menu = get_node("Menu")
@onready var next = get_node("Next Level")

@export var gamestate: = "":
	get:
		return gamestate
	set(value):
		gamestate = value
		if gamestate == "game_over":
			label.text = "Oopsie... your score was %s, but your goal was %s" % [ GameData.score, GameData.goal ];
			next.visible = false
			menu.visible = false
			try.visible = true
		if gamestate == "next_level":
			label.text = "Who hoo! You reached your goal! Would you like to go to level %s?" % [ GameData.level + 2 ];
			next.visible = true
			menu.visible = false
			try.visible = false
		if gamestate == "game_won":
			label.text = "You won all the math! And you are very clean! Thanks for playing! :)";
			next.visible = false
			menu.visible = true
			try.visible = false
			

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	GameData.score = 0
	GameData.level = -1
	visible = false
	get_tree().change_scene_to_file("res://src/scenes/game_screen.tscn")  # Reload the current scene
	
func _on_next_level_button_up() -> void:
	GameData.score = 0
	visible = false
	get_tree().change_scene_to_file("res://src/scenes/game_screen.tscn")  # Reload the current scene
	
func _on_menu_button_up() -> void:
	GameData.score = 0
	GameData.level = -1
	visible = false
	get_tree().change_scene_to_file("res://src/scenes/start_screen.tscn")

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
