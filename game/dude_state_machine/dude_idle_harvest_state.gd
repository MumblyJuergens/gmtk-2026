class_name DudeIdleHarvestState extends DudeState

func enter(dude: Dude) -> void:
	if dude.stuff >= Config.DUDE_COLLECTION_CAPACITY * stats.strength:
		var bases := dude.get_tree().get_nodes_in_group("bases")
		var my_base: Base
		var min_distance: float = 10000.0
		for base in bases:
			if base is Base and base.team == dude.team:
				var sbase: Base = base
				if sbase.stuff != 0:
					var distance := sbase.position.distance_to(dude.position)
					if distance < min_distance:
						my_base = sbase
						min_distance = distance
		if my_base:
			dude.destination = my_base
			dude.change_state(DudeMachine.State.MOVE_TO_BASE)		
	else:
		var stuff_piles := dude.get_tree().get_nodes_in_group("stuff_piles")
		var my_pile: StuffPile
		var min_distance: float = 10000.0
		for pile in stuff_piles:
			if pile is StuffPile and pile.team == dude.team:
				var spile: StuffPile = pile
				if spile.stuff != 0:
					var distance := spile.position.distance_to(dude.position)
					if distance < min_distance:
						my_pile = spile
						min_distance = distance
		if my_pile:
			dude.destination = my_pile
			dude.change_state(DudeMachine.State.MOVE_TO_PILE)
