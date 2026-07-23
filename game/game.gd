class_name Game
extends Node2D

var stats: Stats
@onready var game_timer: GameTimer = %GameTimer
@onready var hand: Hand = %Hand
@onready var stats_display: StatsDisplay = %StatsDisplay

func _ready() -> void:	
	stats = Stats.new()
	game_timer.stats = stats
	stats_display.stats = stats
	
	EventBus.card_used.connect(stats.apply_card)
	EventBus.stats_changed.connect(stats_display.update_stats)
	EventBus.timer_done_card_use.connect(hand.discard_or_use_random)
	EventBus.card_pull_from_deck.connect(hand.draw_card)
	
	# TODO: Remove, should be called after tutorial screen.
	start_round()

func _exit_tree() -> void:
	# This probably isn't necesssary but *shrug*
	EventBus.disconnect_all()

func start_round() -> void:
	# TODO: Call stop on things we start()
	EventBus.stats_changed.emit()
	game_timer.start()
	hand.draw_cards()
