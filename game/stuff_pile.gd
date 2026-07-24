class_name StuffPile
extends Sprite2D

@onready var label: Label = %Label

var stuff: float
var team := 0

func _ready() -> void:
	stuff = SharedJunk.rng.randf_range(Config.STUFF_PILE_MIN, Config.STUFF_PILE_MAX)

func is_empty() -> bool:
	return stuff <= 0.00
	
func _process(delta: float) -> void:
	label.text = "%.2f" % [stuff]
