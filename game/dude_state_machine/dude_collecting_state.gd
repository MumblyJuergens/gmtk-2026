class_name DudeCollectingState extends DudeState

func process(dude: Dude, delta: float) -> void:
	if dude.destination is StuffPile:
		var pile: StuffPile = dude.destination
		if pile.stuff > 0.0:
			var amount := Config.DUDE_COLLECTION_RATE * stats.speed * delta
			if amount > pile.stuff:
				amount = pile.stuff
				pile.stuff = 0
			else:
				pile.stuff -= amount
			dude.stuff += amount
		else:
			dude.change_state(DudeMachine.State.IDLE_HARVEST)
		if dude.stuff >= Config.DUDE_COLLECTION_CAPACITY * stats.strength:
			dude.change_state(DudeMachine.State.MOVE_TO_BASE)
