class_name DudeDeadState
extends DudeState

func enter(dude: Dude) -> void:
	dude.modulate = Color.GHOST_WHITE # lol
	var end_color := Color.GHOST_WHITE - Color(0, 0, 0, 1)
	dude.play("ascending")
	var tween := dude.get_tree().create_tween()
	tween.tween_property(dude, "modulate", end_color, 1.0)
	tween.parallel()
	tween.tween_property(dude, "position", dude.position + Vector2(0, -10), 1.0)
