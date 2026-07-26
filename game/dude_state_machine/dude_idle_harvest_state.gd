class_name DudeIdleHarvestState
extends DudeState

func enter(dude: Dude) -> void:
	var has_capacity := dude.stuff < Config.DUDE_COLLECTION_CAPACITY * stats_for(dude).strength
	if has_capacity:
		var stuff_pile := _find_stuff_pile(dude)
		if not stuff_pile:
			_find_base(dude)
	else:
		_find_base(dude)


func _find_base(dude: Dude) -> Node:
	var checker: Callable = func(node: Node2D) -> bool: return node is Base
	var group: StringName = "bases"
	var new_state: DudeMachine.State = DudeMachine.State.MOVE_TO_BASE
	return _find_node(dude, checker, group, new_state)


func _find_stuff_pile(dude: Dude) -> Node:
	var checker: Callable = func(node: Node2D) -> bool: return node is StuffPile and node.stuff > 0
	var group: StringName = "stuff_piles"
	var new_state: DudeMachine.State = DudeMachine.State.MOVE_TO_PILE
	return _find_node(dude, checker, group, new_state)


func _find_node(dude: Dude, checker: Callable, group: StringName, new_state: DudeMachine.State) -> Node:
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
		return my_base

	return null
