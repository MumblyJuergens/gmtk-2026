extends Node

var rng: RandomNumberGenerator
var last_result: bool = true

static var _team_modulations: Array[Color] = [
	Color.LIGHT_BLUE,
	Color.LIGHT_CORAL,
]


func _ready() -> void:
	rng = RandomNumberGenerator.new()


func team_modulation(team: int) -> Color:
	return _team_modulations[team]
