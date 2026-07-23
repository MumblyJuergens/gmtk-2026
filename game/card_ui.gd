class_name CardUI
extends Panel

@onready var what: Label = $What
@onready var amount: Label = $Amount

var card_data: CardData

func _ready() -> void:
	var enum_text: String = CardData.Effect.keys()[card_data.effect]
	enum_text = enum_text.replace("_", "\n")
	var op := "*" if card_data.effect_op == CardData.EffectOp.MULTIPLY else "+"
	
	what.text = enum_text
	amount.text = "%s%2.2f" % [op, card_data.amount]


func _on_yep_pressed() -> void:
	EventBus.card_used.emit(card_data)
	queue_free()


func _on_nope_pressed() -> void:
	EventBus.card_discarded.emit(card_data)
	queue_free()
