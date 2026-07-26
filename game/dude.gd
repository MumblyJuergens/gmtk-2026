class_name Dude
extends AnimatedSprite2D

@onready var state_machine: DudeMachine = DudeMachine.new()
var team := 0
var destination: Node2D
var stuff := 0.0
var task_timer := 0.0
var health := Config.DUDE_STARTING_HEALTH


func setup(team_value: int, pos: Vector2i) -> void:
	team = team_value
	position = pos
	modulate = SharedJunk.team_modulation(team)
	state_machine.setup(self)


func change_state(state: DudeMachine.State) -> void:
	state_machine.change_state(self, state)


func _process(delta: float) -> void:
	if health <= 0.0 and state_machine.current_state_type != DudeMachine.State.DEAD:
		change_state(DudeMachine.State.DEAD)
	state_machine.process(self, delta)


func _physics_process(delta: float) -> void:
	state_machine.physics_process(self, delta)


func round_changed() -> void:
	state_machine.change_state(self, DudeMachine.new_dude_state)


func play_hit_sfx() -> void:
	AudioQueue.play(0)


func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent := area.get_parent()
	if not parent:
		return
	if parent is StuffPile and state_machine.current_state_type == DudeMachine.State.MOVE_TO_PILE:
		var pile: StuffPile = parent
		if pile == destination:
			change_state(DudeMachine.State.COLLECTING)
	if parent is Base:
		if state_machine.current_state_type == DudeMachine.State.MOVE_TO_BASE:
			var base: Base = parent
			if base == destination:
				change_state(DudeMachine.State.DEPOSITING)
		elif state_machine.current_state_type == DudeMachine.State.MOVE_TO_BASE_ANGRILY:
			var base: Base = parent
			if base == destination:
				change_state(DudeMachine.State.ATTACK_BASE_STATE)
