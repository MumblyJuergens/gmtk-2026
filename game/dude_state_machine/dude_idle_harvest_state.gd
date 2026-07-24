class_name DudeIdleHarvestState extends DudeState

func enter(dude: Dude) -> void:
	var checker: Callable
	var group: StringName
	var new_state: DudeMachine.State 
	
	if dude.stuff >= Config.DUDE_COLLECTION_CAPACITY * stats.strength:
		checker = func(node: Node2D)->bool: return node is Base
		group = "bases"
		new_state = DudeMachine.State.MOVE_TO_BASE
	else:
		checker = func(node: Node2D)->bool: return node is StuffPile and node.stuff > 0
		group = "stuff_piles"
		new_state = DudeMachine.State.MOVE_TO_PILE
		
	var bases := dude.get_tree().get_nodes_in_group(group)
	var my_base: Node2D
	var min_distance: float = 10000.0
	for base in bases:
		if checker.call(base) and base.team == dude.team:
			var sbase: Node2D = base
			if sbase.stuff != 0:
				var distance := sbase.position.distance_to(dude.position)
				if distance < min_distance:
					my_base = sbase
					min_distance = distance
	if my_base:
		dude.destination = my_base
		dude.change_state(new_state)
