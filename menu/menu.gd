class_name Menu
extends Control

signal switch_scene(scene_key: String)
@onready var label_2: Label = $Label2


func _ready() -> void:
	label_2.text = "Version %s" % [ProjectSettings.get_setting("application/config/version")]


func _on_begin_pressed() -> void:
	switch_scene.emit("game")
