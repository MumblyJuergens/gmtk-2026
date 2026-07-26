class_name Game
extends Node2D

var stats: Stats
var enemy_stats: Stats
var game_round := 0
@onready var round_timer: GameTimer = %RoundTimer
@onready var autoplay_timer: GameTimer = %AutoplayTimer
@onready var hand: Hand = %Hand
@onready var stats_display: StatsDisplay = %StatsDisplay
@onready var base: Base = $Base
@onready var enemy_base: Base = $EnemyBase
@onready var round_annouce_label: Label = %RoundAnnouceLabel

signal switch_scene(key: String)


func _ready() -> void:
	stats = Stats.new()
	enemy_stats = Stats.new()
	stats_display.stats = stats
	base.stats = stats
	enemy_base.stats = enemy_stats
	DudeState.static_stats = [stats, enemy_stats]
	DudeMachine.new_dude_state = DudeMachine.State.IDLE_HARVEST

	EventBus.card_used.connect(stats.apply_card)
	EventBus.stats_changed.connect(stats_display.update_stats)
	EventBus.timer_done_card_use.connect(hand.discard_or_use_random)
	EventBus.card_pull_from_deck.connect(hand.draw_card)
	EventBus.timer_done_round.connect(_round_done)

	round_timer.emit_at.connect(EventBus.timer_done_round.emit)
	autoplay_timer.emit_at.connect(EventBus.timer_done_card_use.emit)

	round_timer.duration = Config.GAME_TIMER_ROUND_DURATION
	autoplay_timer.duration = Config.GAME_TIMER_USE_DURATION

	autoplay_timer.get_modifier = func() -> float: return stats.timer_speed

	# TODO: Remove, should be called after tutorial screen.
	start_round()


func _process(_delta: float) -> void:
	# TODO: Fix for multiple bases
	if base.stuff < 0:
		SharedJunk.last_result = false
		switch_scene.emit("game_over")
	if enemy_base.stuff < 0:
		SharedJunk.last_result = true
		switch_scene.emit("game_over")


func _exit_tree() -> void:
	# This probably isn't necesssary but *shrug*
	EventBus.disconnect_all()


func start_round() -> void:
	# TODO: Call stop on things we start()
	EventBus.stats_changed.emit()
	round_timer.start()
	autoplay_timer.start()
	hand.draw_cards()
	base.go()
	enemy_base.go()
	_annouce_round("Harvest Round!", Color.GREEN)


func _round_done() -> void:
	game_round += 1
	DudeMachine.round_changed(game_round, get_tree())
	if game_round % 2 == 0:
		_annouce_round("Harvest Round!", Color.GREEN)
	else:
		_annouce_round("BATTLE Round!", Color.RED)


func _annouce_round(text: String, color: Color) -> void:
	round_annouce_label.text = text
	round_annouce_label.label_settings.font_color = color
	round_annouce_label.visible = true
	var tween := get_tree().create_tween()
	tween.tween_property(round_annouce_label, "modulate:a", 1, 0.5)
	tween.tween_property(round_annouce_label, "position:y", -20.0, 0.5)
	tween.parallel().tween_property(round_annouce_label, "modulate:a", 0, 0.5)
	tween.tween_callback(
		func() -> void:
			round_annouce_label.position.y = 111.0
			round_annouce_label.visible = false
	)
