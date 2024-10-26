extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 40
const DECCELERATION: = 60

@export var sprite: AnimatedSprite2D
var coyote_time: float = 1


func _process(delta: float) -> void:
	coyote_time -= delta

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		coyote_time = 0
		velocity.y = 0
	
	if Input.is_action_pressed("ui_accept") and coyote_time == 0:
		velocity.y = JUMP_VELOCITY
		sprite.play("jump")
	
	# Play fall animation
	if velocity.y > 0:
		sprite.play("falling")
	
	# Cut out the jump if release the button early
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
