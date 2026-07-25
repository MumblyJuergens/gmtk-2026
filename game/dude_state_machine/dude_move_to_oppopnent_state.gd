class_name DudeMoveToOpponentState
extends DudeState

func enter(dude: Dude) -> void:
	dude.play("walking")


func exit(dude: Dude) -> void:
	dude.stop()


func process(dude: Dude, _delta: float) -> void:
	if not dude.destination:
		push_warning("No destination is set")
		return
	if not dude.destination is Dude:
		push_warning("Moving to an enemy but none are set!")
		return

	# Didn't want to mess around with area2d's here, too
	# many call with so many dudes probably?
	if dude.position.distance_to(dude.destination.position) < 5.0:
		dude.change_state(DudeMachine.State.FIGHT)

	var direction: Vector2 = dude.destination.position - dude.position
	dude.position += direction.normalized() * Config.DUDE_SPEED * stats_for(dude).speed
	dude.flip_h = direction.x < 0
