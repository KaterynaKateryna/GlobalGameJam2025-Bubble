extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY_Y = -800.0
const JUMP_VELOCITY_X = -100.0

func _physics_process(delta: float) -> void:
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
