extends Control

var bubble_scene = preload("res://src/objects/bubble.tscn")
var rng = RandomNumberGenerator.new()

@onready var player = get_node("Player")
@onready var game_over_player = get_node("GameOverPlayer")
@onready var next_level_player = get_node("NextLevelPlayer")

var top_row_y;
var bubbles_mid_x;

var bubbles_step_x = 320;
var bubbles_step_y = 320;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.next_level()
	GameData.game_over.connect(_on_game_over)
	GameData.score_updated.connect(_check_end_level)
	
	GameData.score = 0;
	
	var viewport = get_viewport()
	var screen_size = viewport.get_visible_rect().size
	var camera = viewport.get_camera_2d()
	
	var rows_init = screen_size.y / bubbles_step_y
	
	bubbles_mid_x = camera.global_position.x
	for i in range(rows_init):
		var y = camera.global_position.y - i * bubbles_step_y - 180;
		_spawn_row_of_bubbles(bubbles_mid_x, y)
		
	player.jumped_on_bubble.connect(_spawn_more_bubbles)
	
func _spawn_more_bubbles():
	var y = top_row_y - bubbles_step_y
	_spawn_row_of_bubbles(bubbles_mid_x, y)
	
func _spawn_row_of_bubbles(bubbles_mid_x, y):
	_create_bubble(bubbles_mid_x, y, _get_random_modifier())  
	_create_bubble(bubbles_mid_x - bubbles_step_x, y, _get_random_modifier())
	_create_bubble(bubbles_mid_x + bubbles_step_x, y, _get_random_modifier())
	top_row_y = y
			
			
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
		if rand < 0.4:
			return "+1"
		else:
			return "-1"
		
	var modifier
	var rand_modifier = rng.randi_range(0, 3)
	if rand_modifier == 0:
		modifier = "+10"
	elif rand_modifier == 1:
		modifier = "-20"
	elif rand_modifier == 2:
		modifier = "x20"
	elif rand_modifier == 3:
		modifier = "÷2"
	return modifier
	
func _on_game_over():
	print("game over")
	var overlay = get_node("Overlay")
	overlay.gamestate = "game_over"
	overlay.show()
	game_over_player.play()
	
func _check_end_level():
	if GameData.score == GameData.goal:
		var overlay = get_node("Overlay")
		if GameData.level == GameData.levels.size() - 1:
			overlay.gamestate = "game_won"
		else:
			overlay.gamestate = "next_level"
		overlay.show()
		next_level_player.play()
	
	
