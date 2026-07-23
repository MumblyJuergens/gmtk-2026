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
	
	EventBus.disconnect_all()
	EventBus.card_used.connect(stats.apply_card)
	EventBus.stats_changed.connect(stats_display.update_stats)
	
	# TODO: Remove, should be called after tutorial screen.
	start_round()

func start_round() -> void:
	EventBus.stats_changed.emit()
	game_timer.start()
	hand.draw_cards()
