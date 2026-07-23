class_name GameTimer
extends Panel

@onready var round_time: Label = %RoundTime
@onready var use_time: Label = %UseTime

@onready var _round_timer: Timer = $RoundTimer
@onready var _use_timer: Timer = $UseTimer

const ROUND_DURATION: float = 120.0
const USE_DURATION: float = 5.0

var stats: Stats

func start() -> void:
	if not stats:
		push_error("Stats must be set before starting timers!")
	if not _round_timer.timeout.is_connected(_on_round_timer_timeout):
		_round_timer.timeout.connect(_on_round_timer_timeout)
	if not _use_timer.timeout.is_connected(_on_use_timer_timeout):
		_use_timer.timeout.connect(_on_use_timer_timeout)
	_round_timer.start(ROUND_DURATION)
	_use_timer.start(USE_DURATION)

func stop() -> void:
	_round_timer.stop()
	_use_timer.stop()

func _process(_delta: float) -> void:
	_set_time_reading(round_time, _round_timer)
	_set_time_reading(use_time, _use_timer)
	
func _set_time_reading(label: Label, timer: Timer) -> void:
	var seconds := int(timer.time_left)
	@warning_ignore("integer_division")
	label.text = "%02d:%02d" % [seconds / 60, seconds % 60]
	
func _on_round_timer_timeout() -> void:
	_round_timer.stop()
	EventBus.timer_done_round.emit()
	
func _on_use_timer_timeout() -> void:
	_use_timer.start(USE_DURATION)
	EventBus.timer_done_card_use.emit()
