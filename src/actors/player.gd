extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY_Y = -900.0
const JUMP_VELOCITY_X = -180.0

var is_on_duck = false
var is_on_bubble = false
var bubble = null
var bath
var duck

var left_margin
var right_margin

signal jumped_on_bubble

func _ready():
	var viewport = get_viewport()
	var screen_size = viewport.get_visible_rect().size
	var camera = viewport.get_camera_2d()

	bath = get_tree().root.get_node("GameScreen/Bath/CollisionShape2D")
	duck = get_tree().root.get_node("GameScreen/Duck")
	
	left_margin = bath.global_position.x - bath.shape.extents.x
	right_margin = bath.global_position.x + bath.shape.extents.x
	
	camera.limit_bottom = screen_size.y + 300	

func _physics_process(delta: float) -> void:
	
	if global_position.x < left_margin || global_position.x > right_margin:
		print("out of bounds: (%s, %s) %s" % [left_margin, right_margin, global_position.x])
		GameData.emit_game_over()
		
	
	if is_on_floor():
		velocity.x = 0
		
	if is_on_bubble and bubble:
		velocity.x = bubble.velocity.x
		velocity.y = bubble.velocity.y
		
	if is_on_duck:
		velocity.x = duck.velocity.x
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_bubble):
		velocity.y = JUMP_VELOCITY_Y
		velocity.x = JUMP_VELOCITY_X

		var mousePosition = get_global_mouse_position()
		var direction = mousePosition.x - position.x
		if (direction > -75 and direction < 75):
			velocity.x = 0
		
		if (direction > 0):
			velocity.x = velocity.x * -1.0

	move_and_slide()

func _on_bubble_detector_body_entered(body: Node2D) -> void:
	if velocity.y < 0:
		return # going up
	is_on_bubble = true
	bubble = body
	
	jumped_on_bubble.emit()
	
	var modifier = body.get_modifier()
	var operator = modifier.substr(0,1)
	var operand = modifier.substr(1)
	var operand_int = int(operand)
	if operator == "+":
		GameData.score += operand_int
	if operator == "-":
		GameData.score -= operand_int
	if operator == "x":
		GameData.score *= operand_int
	if operator == "%":
		GameData.score /= operand_int
		
func _on_bubble_detector_body_exited(body: Node2D) -> void:
	if is_on_bubble and bubble:
		is_on_bubble = false
		bubble.queue_free()	
		bubble = null

func _on_duck_detector_body_entered(body: Node2D) -> void:
	is_on_duck = true

func _on_duck_detector_body_exited(body: Node2D) -> void:
	is_on_duck = false

func _on_bath_detector_body_entered(body: Node2D) -> void:
	GameData.emit_game_over()
