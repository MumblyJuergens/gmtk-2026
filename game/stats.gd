class_name Stats

var speed: float = 1.0
var strength: float = 1.0
var defence: float = 1.0
var spawn_speed: float = 1.0
var spawn_cost: float = 1.0
var timer_speed: float = 1.0

func apply_card(card_data: CardData) -> void:
	# TODO: Extensible with OOP or whatever
	var op: Callable
	match card_data.effect_op:
		CardData.EffectOp.ADD: op = _add_me
		CardData.EffectOp.MULTIPLY: op = _multiply_me
	match card_data.effect:
		CardData.Effect.SPEED: speed = op.call(speed, card_data.amount)
		CardData.Effect.STENGTH: strength = op.call(strength, card_data.amount)
		CardData.Effect.DEFENCE: defence = op.call(defence, card_data.amount)
		CardData.Effect.SPAWN_SPEED: spawn_speed = op.call(spawn_speed, card_data.amount)
		CardData.Effect.SPAWN_COST: spawn_cost = op.call(spawn_cost, card_data.amount)
		CardData.Effect.TIMER_SPEED: timer_speed = op.call(timer_speed, card_data.amount)
	EventBus.stats_changed.emit()

func _add_me(variable: float, amount: float) -> float:
	return variable + amount

func _multiply_me(variable: float, amount: float) -> float:
	return variable * amount
