class_name StuffPile
extends Sprite2D

var stuff: float
var team := 0

func _ready() -> void:
	stuff = SharedJunk.rng.randf_range(Config.STUFF_PILE_MIN, Config.STUFF_PILE_MAX)
