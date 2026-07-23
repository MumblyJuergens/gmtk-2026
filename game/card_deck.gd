extends Control

@onready var pull_card: Button = %PullCard
@onready var timer: Timer = %Timer

const WAIT_TIME := 2.0

func _ready() -> void:
	EventBus.card_pull_wait.connect(_on_card_pull_wait)

func _process(_delta: float) -> void:
	if not timer.is_stopped():
		pull_card.text = "Wait...\n%02d" % [int(timer.time_left)]

func _on_pull_card_pressed() -> void:
	EventBus.card_pull_from_deck.emit()

func _on_card_pull_wait() -> void:
	pull_card.disabled = true
	timer.start(WAIT_TIME)
	
func _on_timer_timeout() -> void:
	pull_card.disabled = false
	pull_card.text = "GMTK\n2026"
	timer.stop()
