class_name StuffPile
extends Sprite2D

@onready var label: Label = %Label

var stuff: float
var team := 0

func _ready() -> void:
	stuff = SharedJunk.rng.randf_range(Config.STUFF_PILE_MIN, Config.STUFF_PILE_MAX)
	modulate = SharedJunk.team_modulation(team)

func is_empty() -> bool:
	return stuff <= 0.00
	
func _process(_delta: float) -> void:
	label.text = "%.2f" % [stuff]
