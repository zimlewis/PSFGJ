extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 40
const DECCELERATION: = 60


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if !is_on_floor() and Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= 0.5           

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECCELERATION)

	move_and_slide()
