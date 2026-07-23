class_name Game
extends Node2D

var stats: Stats

func _ready() -> void:
	EventBus.disconnect_all()
	stats = Stats.new()
