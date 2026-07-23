class_name Game
extends Node2D

var stats: Stats
@onready var game_timer: GameTimer = %GameTimer
@onready var hand: Hand = %Hand

func _ready() -> void:
	EventBus.disconnect_all()
	stats = Stats.new()
	game_timer.stats = stats
	EventBus.card_used.connect(stats.apply_card)
	
	# TODO: Remove, should be called after tutorial screen.
	start_round()

func start_round() -> void:
	game_timer.start()
	hand.draw_cards()
