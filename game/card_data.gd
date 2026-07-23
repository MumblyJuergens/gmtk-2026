class_name CardData

enum Effect { SPEED, STENGTH, DEFENCE, SPAWN_SPEED, SPAWN_COST, TIMER_SPEED, }
enum EffectOp { ADD, MULTIPLY, }

var effect: Effect
var effect_op: EffectOp
var amount: float
