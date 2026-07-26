class_name DudeIdleBattleState
extends DudeState

# TODO: Be Better
func enter(dude: Dude) -> void:
	var enemies := dude.get_tree().get_nodes_in_group("dudes").filter(func(node: Node) -> bool: return node is Dude and node.team != dude.team and node.health > 0.0)
	var my_opponent: Dude
	var min_distance: float = 10000.0
	for enemy: Node in enemies:
		var enemy_dude: Dude = enemy
		var distance := enemy_dude.position.distance_to(dude.position)
		if distance < min_distance:
			my_opponent = enemy_dude
			min_distance = distance
	if my_opponent:
		dude.destination = my_opponent
		dude.change_state(DudeMachine.State.MOVE_TO_OPPONENT)
	else:
		var enemy_bases := dude.get_tree().get_nodes_in_group("bases").filter(func(node: Node) -> bool: return node is Base and node.team != dude.team and node.stuff > 0.0)
		var my_opponent_base: Base
		var min_distance_base: float = 10000.0
		for enemy: Node in enemy_bases:
			var enemy_dude_base: Base = enemy
			var distance := enemy_dude_base.position.distance_to(dude.position)
			if distance < min_distance_base:
				my_opponent_base = enemy_dude_base
				min_distance = distance
		if my_opponent_base:
			dude.destination = my_opponent_base
			dude.change_state(DudeMachine.State.MOVE_TO_BASE_ANGRILY)
