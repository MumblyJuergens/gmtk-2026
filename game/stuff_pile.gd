extends Sprite2D

var stuff: float

func _ready() -> void:
	stuff = SharedJunk.rng.randf_range(1000.0, 10000.0)
