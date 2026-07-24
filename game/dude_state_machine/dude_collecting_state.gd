class_name DudeCollectingState extends DudeState

func process(dude: Dude, delta: float) -> void:
	if dude.destination is StuffPile:
		var pile: StuffPile = dude.destination
		var capacity := Config.DUDE_COLLECTION_CAPACITY * stats.strength
		if pile.is_empty() or dude.stuff >= capacity:
			dude.change_state(DudeMachine.State.IDLE_HARVEST)
			return
		var amount := Config.DUDE_COLLECTION_RATE * stats.speed * delta
		if amount > pile.stuff:
			amount = pile.stuff
			pile.stuff = 0.0
		else:
			pile.stuff -= amount
		dude.stuff += amount
