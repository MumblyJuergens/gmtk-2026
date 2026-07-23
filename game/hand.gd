class_name Hand
extends HBoxContainer

const CARD_UI = preload("uid://dbqqioutkatvs")
const CARD_DRAW_INTERVAL := 0.25

func spawn_card(card_data: CardData) -> void:
	if get_child_count() > 5:
		push_error("Tried to draw over 5 cards!")
		return
	var card_ui: CardUI = CARD_UI.instantiate()
	card_ui.card_data = card_data
	add_child(card_ui)

func draw_cards() -> void:
	var tween := create_tween()
	for _i in range(Config.CARD_COUNT):
		tween.tween_callback(_draw_card)
		tween.tween_interval(CARD_DRAW_INTERVAL)

func _draw_card() -> void:
	# TODO: Create random cards.
	var card_data := CardData.new()
	card_data.effect = CardData.Effect.SPAWN_SPEED
	card_data.effect_op = CardData.EffectOp.ADD
	card_data.amount = 0.5
	spawn_card(card_data)
