class_name DudeMachine

enum State {
	IDLE_HARVEST,
	MOVE_TO_PILE,
	COLLECTING,
	MOVE_TO_BASE,
	DEPOSITING,
	IDLE_BATTLE,
	MOVE_TO_OPPONENT,
	FIGHT,
	DEAD,
	MOVE_TO_BASE_ANGRILY,
	ATTACK_BASE_STATE,
}

static var _states: Dictionary[State, DudeState] = {
	State.IDLE_HARVEST: DudeIdleHarvestState.new(),
	State.MOVE_TO_PILE: DudeMoveToPileState.new(),
	State.COLLECTING: DudeCollectingState.new(),
	State.MOVE_TO_BASE: DudeMoveToBaseState.new(),
	State.DEPOSITING: DudeDepositingState.new(),
	State.IDLE_BATTLE: DudeIdleBattleState.new(),
	State.MOVE_TO_OPPONENT: DudeMoveToOpponentState.new(),
	State.FIGHT: DudeFightState.new(),
	State.DEAD: DudeDeadState.new(),
	State.MOVE_TO_BASE_ANGRILY: DudeMoveToBaseAngrilyState.new(),
	State.ATTACK_BASE_STATE: DudeAttackBaseState.new(),
}
static var new_dude_state: State = State.IDLE_HARVEST

var current_state: DudeState
# Allow for the possibilty of not shared state instances.
var current_state_type: State


static func round_changed(game_round: int, tree: SceneTree) -> void:
	if game_round % 2 == 0:
		new_dude_state = State.IDLE_HARVEST
		var died_last_round := tree.get_nodes_in_group("dudes").filter(func(node: Node) -> bool: return node is Dude and node.health < 0.0)
		for dude: Node in died_last_round:
			dude.queue_free()
	else:
		new_dude_state = State.IDLE_BATTLE
	tree.call_group("dudes", "round_changed")


func _init() -> void:
	current_state = _states[new_dude_state]


func setup(dude: Dude) -> void:
	current_state.enter(dude)


func change_state(dude: Dude, state: State) -> void:
	var new_state: DudeState = _states[state]
	if not new_state:
		push_error("Unknown state to enter")
		return
	if current_state_type == state:
		push_warning("Already in that state: %s" % [State.keys()[state]])
		return

	if current_state:
		current_state.exit(dude)
	current_state = new_state
	current_state_type = state
	current_state.enter(dude)


func process(dude: Dude, delta: float) -> void:
	if current_state:
		current_state.process(dude, delta)


func physics_process(dude: Dude, delta: float) -> void:
	if current_state:
		current_state.physics_process(dude, delta)
