class_name Player extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 40
const DECCELERATION: = 60

@export var sprite: AnimatedSprite2D
var coyote_time: float = 1
var gravity = Vector2(0, 100)

func _process(delta: float) -> void:
	coyote_time -= delta

func _physics_process(delta: float) -> void:
	# Add the gravity.

	# Handle jump.
	if is_on_floor():
		coyote_time = 0
	 
	move_and_slide()
