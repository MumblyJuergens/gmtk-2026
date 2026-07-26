class_name DudeAttackBaseState
extends DudeState

func process(dude: Dude, delta: float) -> void:
	if not dude.destination is Base:
		push_warning("Enemy isn't a base")
		return
	dude.play("fighting")
	var enemy: Base = dude.destination
	dude.task_timer += delta
	var swing_speed := Config.DUDE_SWING_SPEED / stats_for(dude).speed
	if dude.task_timer > swing_speed:
		dude.play_hit_sfx()
		dude.task_timer = swing_speed - dude.task_timer
		var damage := Config.DUDE_SWING_DAMAGE * stats_for(dude).strength / stats_for_base(enemy).defence
		enemy.stuff -= damage
		if enemy.stuff < 0.0:
			dude.change_state(DudeMachine.State.IDLE_BATTLE)
