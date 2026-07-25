class_name DudeIdleBattleState
extends DudeState

func enter(dude: Dude) -> void:
	var enemies := dude.get_tree().get_nodes_in_group("dudes").filter(func(node: Node) -> bool: return node is Dude and node.team != dude.team)
	var my_opponent: Dude
	var min_distance: float = 10000.0
	for enemy in enemies:
		var enemy_dude: Dude = enemy
		var distance := enemy_dude.position.distance_to(dude.position)
		if distance < min_distance:
			my_opponent = enemy_dude
			min_distance = distance
	if my_opponent:
		dude.destination = my_opponent
		dude.change_state(DudeMachine.State.MOVE_TO_OPPONENT)
