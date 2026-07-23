class_name CardData

enum Effect { SPEED, STRENGTH, DEFENCE, SPAWN_SPEED, SPAWN_COST, TIMER_SPEED, }
enum EffectOp { ADD, MULTIPLY, }

var effect: Effect
var effect_op: EffectOp
var amount: float

static func random() -> CardData:
	var card_data := CardData.new()
	card_data.effect = _random_effect()
	card_data.effect_op = _random_effect_op()
	card_data.amount = _random_amount()
	return card_data

class WeightedEffect extends RefCounted:
	var effect: Effect
	var weight: float
	var accum_weight: float = 0.0
	func _init(e: Effect, w: float) -> void:
		effect = e
		weight = w

class WeightedEffectOp extends RefCounted:
	var effect_op: EffectOp
	var weight: float
	var accum_weight: float = 0.0
	func _init(e: EffectOp, w: float) -> void:
		effect_op = e
		weight = w

static func _static_init() -> void:
	_total_weight_effect = 0.0
	_total_weight_effect_op = 0.0
	for we in _effect_chances:
		_total_weight_effect += we.weight
		we.accum_weight = _total_weight_effect
	for we in _effect_op_chances:
		_total_weight_effect_op += we.weight
		we.accum_weight = _total_weight_effect_op

static var _total_weight_effect: float = 0.0
static var _total_weight_effect_op: float = 0.0
static var _effect_chances: Array[WeightedEffect] = [
	WeightedEffect.new(Effect.SPEED, 1.0),
	WeightedEffect.new(Effect.STRENGTH, 1.0),
	WeightedEffect.new(Effect.DEFENCE, 1.0),
	WeightedEffect.new(Effect.SPAWN_SPEED, 1.0),
	WeightedEffect.new(Effect.SPAWN_COST, 1.0),
	WeightedEffect.new(Effect.TIMER_SPEED, 1.0),
]

static var _effect_op_chances: Array[WeightedEffectOp] = [
	WeightedEffectOp.new(EffectOp.ADD, 1.0),
	WeightedEffectOp.new(EffectOp.MULTIPLY, 1.0),
]

static func _random_effect() -> Effect:
	var roll := SharedJunk.rng.randf_range(0.0, _total_weight_effect)
	for we in _effect_chances:
		if we.accum_weight > roll:
			return we.effect
	push_warning("Default effect chosen, maths is bad")
	return Effect.SPEED
	
static func _random_effect_op() -> EffectOp:
	var roll := SharedJunk.rng.randf_range(0.0, _total_weight_effect_op)
	for we in _effect_op_chances:
		if we.accum_weight > roll:
			return we.effect_op
	push_warning("Default effect op chosen, maths is bad")
	return EffectOp.ADD
	
static func _random_amount() -> float:
	return SharedJunk.rng.randf_range(0.5, 2.0)
