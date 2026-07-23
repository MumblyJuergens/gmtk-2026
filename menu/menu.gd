class_name Menu
extends Control

signal switch_scene(scene_key: String)


func _on_begin_pressed() -> void:
	switch_scene.emit("game")
