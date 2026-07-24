class_name Base extends Sprite2D

const DUDE = preload("uid://b2gjm0u0af0c0")
@onready var make_dude_timer: Timer = %MakeDudeTimer
@onready var dudes: Node2D = %Dudes
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var make_dude: TextureButton = %MakeDude

@export var stuff: float = 50.0
@export var team: int = 0
var stats : Stats

func _on_make_dude_pressed() -> void:
	if not make_dude_timer.is_stopped():
		return
	var cost := Config.BASE_DUDE_SPAWN_COST * stats.spawn_cost
	if stuff >= cost:
		var time := Config.BASE_DUDE_SPAWN_TIME * stats.spawn_speed
		progress_bar.max_value = time
		progress_bar.value = 0.0
		make_dude_timer.start(time)
		stuff -= cost
	

func _on_make_dude_timer_timeout() -> void:
	make_dude_timer.stop()
	var new_dude: Dude = DUDE.instantiate()
	dudes.add_child(new_dude)
	new_dude.setup(team, position)
	progress_bar.value = 0.0

func _process(_delta: float) -> void:
	var time := Config.BASE_DUDE_SPAWN_TIME * stats.spawn_speed
	var cost := Config.BASE_DUDE_SPAWN_COST * stats.spawn_cost
	if make_dude_timer.is_stopped():
		progress_bar.value = 0.0
	else:
		progress_bar.value = time - make_dude_timer.time_left
	make_dude.disabled = stuff < cost


func _on_progress_bar_gui_input(event: InputEvent) -> void:
	if not make_dude_timer.is_stopped():
		return
	if event is InputEventMouseButton:
		var mevent: InputEventMouseButton = event
		if mevent.pressed:
			_on_make_dude_pressed()
