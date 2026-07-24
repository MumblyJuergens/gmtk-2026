class_name DudeMoveToPileState extends DudeState

func enter(dude: Dude) -> void:
	dude.play("walking")

func exit(dude: Dude) -> void:
	dude.stop()

func process(dude: Dude, _delta: float) -> void:
	if not dude.destination or not dude.destination is StuffPile:
		push_warning("Moving to a pile but none are set!")
		return
	
	var direction: Vector2 = dude.destination.position - dude.position
	dude.position += direction.normalized() * Config.DUDE_SPEED * stats.speed
	dude.flip_h = direction.x < 0
