extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY_Y = -800.0
const JUMP_VELOCITY_X = -150.0

var is_on_duck = false

func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity.x = 0
		
	if is_on_duck:
		var duck = get_tree().root.get_node("GameScreen/Duck")
		velocity.x = duck.velocity.x
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY_Y
		velocity.x = JUMP_VELOCITY_X

		var mousePosition = get_global_mouse_position()
		var direction = mousePosition.x - position.x
		if (direction > 0):
			velocity.x = velocity.x * -1.0

	move_and_slide()

func _on_bubble_detector_body_entered(body: Node2D) -> void:
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


func _on_duck_detector_body_entered(body: Node2D) -> void:
	is_on_duck = true

func _on_duck_detector_body_exited(body: Node2D) -> void:
	is_on_duck = false
