class_name DudeDepositingState extends DudeState

func process(dude: Dude, delta: float) -> void:
	if dude.destination is Base:
		var base: Base = dude.destination
		if dude.stuff > 0.0:
			var amount := Config.DUDE_COLLECTION_RATE * stats.speed * delta
			if amount > dude.stuff:
				base.stuff += dude.stuff
				dude.stuff = 0.0
			else:
				base.stuff += amount
				dude.stuff -= amount
		else:
			dude.change_state(DudeMachine.State.IDLE_HARVEST)
