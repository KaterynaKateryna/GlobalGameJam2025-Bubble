extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY_Y = -900.0
const JUMP_VELOCITY_X = -180.0

var is_on_duck = false
var is_on_bubble = false
var bubble = null

func _ready():
	var viewport = get_viewport()
	var screen_size = viewport.get_visible_rect().size
	var camera = viewport.get_camera_2d()
	
	camera.limit_bottom = screen_size.y + 300

func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity.x = 0
		
	if is_on_bubble and bubble:
		velocity.x = bubble.velocity.x
		velocity.y = bubble.velocity.y
		
	if is_on_duck:
		var duck = get_tree().root.get_node("GameScreen/Duck")
		velocity.x = duck.velocity.x
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_bubble):
		print("jump")
		velocity.y = JUMP_VELOCITY_Y
		velocity.x = JUMP_VELOCITY_X

		var mousePosition = get_global_mouse_position()
		var direction = mousePosition.x - position.x
		print(direction)
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
	
	var modifier = body.get_modifier()
	print("bubble jumped body ", modifier)
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
		print("bubble left")

func _on_duck_detector_body_entered(body: Node2D) -> void:
	is_on_duck = true

func _on_duck_detector_body_exited(body: Node2D) -> void:
	is_on_duck = false

func _on_bath_detector_body_entered(body: Node2D) -> void:
	GameData.emit_game_over()
