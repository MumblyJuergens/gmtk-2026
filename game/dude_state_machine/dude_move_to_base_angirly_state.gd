class_name DudeMoveToBaseAngrilyState
extends DudeState

func enter(dude: Dude) -> void:
	dude.play("walking")


func exit(dude: Dude) -> void:
	dude.stop()


func process(dude: Dude, _delta: float) -> void:
	if not dude.destination:
		push_warning("No destination is set")
		return
	if not dude.destination is Base:
		push_warning("Moving to a base angrily but none are set!")
		return

	var direction: Vector2 = dude.destination.position - dude.position
	dude.position += direction.normalized() * Config.DUDE_SPEED * stats_for(dude).speed
	dude.flip_h = direction.x < 0
