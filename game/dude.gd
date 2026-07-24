class_name Dude
extends AnimatedSprite2D

@onready var state_machine: DudeMachine = DudeMachine.new()
var team := 0
var destination: Node2D
var stuff := 0.0
var task_timer := 0.0

static var _team_modulations: Array[Color] = [
	Color.BLUE,
	Color.RED,
]

func setup(team_value: int, pos: Vector2i) -> void:
	team = team_value
	position = pos
	modulate = _team_modulations[team]
	state_machine.setup(self)

func change_state(state: DudeMachine.State) -> void:
	state_machine.change_state(self, state)

func _process(delta: float) -> void:
	state_machine.process(self, delta)

func _physics_process(delta: float) -> void:
	state_machine.physics_process(self, delta)

func round_changed() -> void:
	state_machine.change_state(self, DudeMachine.new_dude_state)

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent := area.get_parent()
	if not parent:
		return
	if parent is StuffPile and state_machine.current_state_type ==  DudeMachine.State.MOVE_TO_PILE:
		var pile: StuffPile = parent
		if pile == destination:
			change_state(DudeMachine.State.COLLECTING)
	if parent is Base and state_machine.current_state_type ==  DudeMachine.State.MOVE_TO_BASE:
		var base: Base = parent
		if base == destination:
			change_state(DudeMachine.State.DEPOSITING)
	
