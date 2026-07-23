class_name StatsDisplay
extends Panel

@onready var speed_label: Label = %SpeedLabel
@onready var strength_label: Label = %StrengthLabel
@onready var defence_label: Label = %DefenceLabel
@onready var spawn_speed_label: Label = %SpawnSpeedLabel
@onready var spawn_cost_label: Label = %SpawnCostLabel
@onready var timer_speed_label: Label = %TimerSpeedLabel

var stats: Stats

func update_stats() -> void:
	if not stats:
		push_error("Stats must be set to display them!")
	set_label(speed_label, stats.speed)
	set_label(strength_label, stats.strength)
	set_label(defence_label, stats.defence)
	set_label(spawn_speed_label, stats.spawn_speed)
	set_label(spawn_cost_label, stats.spawn_cost)
	set_label(timer_speed_label, stats.timer_speed)

func set_label(label: Label, value: float) -> void:
	label.text = "%2.2f" % [value]
