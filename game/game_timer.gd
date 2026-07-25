class_name GameTimer
extends Panel

@export var text: String
@export var duration: float = 1.0
signal emit_at

@onready var _label: Label = %Label
@onready var _timer: Timer = $RoundTimer
@onready var _round_time: Label = %RoundTime

var get_modifier: Callable


func _ready() -> void:
	_label.text = text


func start() -> void:
	if not _timer.timeout.is_connected(_on_timer_timeout):
		_timer.timeout.connect(_on_timer_timeout)
	_restart()


func _restart() -> void:
	var modifier := 1.0
	if get_modifier:
		modifier = get_modifier.call()
	_timer.start(duration * modifier)


func _process(_delta: float) -> void:
	_set_time_reading(_round_time, _timer)


func _set_time_reading(label: Label, timer: Timer) -> void:
	var seconds := int(timer.time_left)
	@warning_ignore("integer_division")
	label.text = "%02d:%02d" % [seconds / 60, seconds % 60]


func _on_timer_timeout() -> void:
	_timer.stop()
	emit_at.emit()
	_restart()
