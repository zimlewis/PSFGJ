extends PlayerState


## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	pass

## Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	player.velocity.y = 0
	var direction := Input.get_axis("move_left", "move_right")
	player.velocity.x = move_toward(player.velocity.x, direction * player.SPEED, player.ACCELERATION)
	
	if direction == 0:
		finished.emit(IDLE)
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	
	if Input.is_action_pressed("jump") and player.coyote_time == 0:
		finished.emit(JUMPING)

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	pass

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	pass