class_name Hand
extends HBoxContainer

const CARD_UI = preload("uid://dbqqioutkatvs")

func spawn_card(card_data: CardData) -> void:
	var card_ui: CardUI = CARD_UI.instantiate()
	card_ui.card_data = card_data
	add_child(card_ui)

func draw_cards() -> void:
	var tween := create_tween()
	for _i in range(Config.CARD_COUNT - get_child_count()):
		tween.tween_callback(draw_card)
		tween.tween_interval(Config.HAND_CARD_DRAW_INTERVAL)

func draw_card() -> void:
	if get_child_count() >= Config.CARD_COUNT:
		return
	# TODO: Create random cards.
	var card_data := CardData.random()
	spawn_card(card_data)
	EventBus.card_pull_wait.emit()

func discard_or_use_random() -> void:
	if get_child_count() == 0:
		return
	var i := SharedJunk.rng.randi_range(0, get_child_count()-1)
	var chosen: CardUI = get_child(i)
	var use := SharedJunk.rng.randi() % 2 == 0
	if use:
		chosen.use()
	else:
		chosen.discard()
