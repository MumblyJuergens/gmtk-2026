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


func _ready() -> void:
	stats = Stats.new()
	enemy_stats = Stats.new()
	stats_display.stats = stats
	base.stats = stats
	enemy_base.stats = enemy_stats
	DudeState.static_stats = [stats, enemy_stats]

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


func _round_done() -> void:
	game_round += 1
	DudeMachine.round_changed(game_round, get_tree())
