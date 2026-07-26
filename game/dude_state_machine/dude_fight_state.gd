class_name DudeFightState
extends DudeState

func process(dude: Dude, delta: float) -> void:
	if not dude.destination is Dude:
		push_warning("Enemy isn't a dude")
		return
	var enemy: Dude = dude.destination
	dude.play("fighting")
	dude.task_timer += delta
	var swing_speed := Config.DUDE_SWING_SPEED / stats_for(dude).speed
	if dude.task_timer > swing_speed:
		dude.task_timer = swing_speed - dude.task_timer
		var damage := Config.DUDE_SWING_DAMAGE * stats_for(dude).strength / stats_for(enemy).defence
		enemy.health -= damage
		if enemy.health < 0.0:
			dude.change_state(DudeMachine.State.IDLE_BATTLE)
