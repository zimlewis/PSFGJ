extends PlayerState


## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	pass

## Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	player.velocity += player.get_gravity() * _delta
	
	var direction := Input.get_axis("move_left", "move_right")
	player.velocity.x = move_toward(player.velocity.x, direction * player.SPEED, player.ACCELERATION)


	if Input.is_action_just_released("jump"):
		player.velocity.y *= 0.5
		finished.emit(FALLING)
	
	if player.velocity.y > 0:
		finished.emit(FALLING)

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = player.JUMP_VELOCITY

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	pass
