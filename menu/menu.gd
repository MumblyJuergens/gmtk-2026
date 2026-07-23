class_name Menu
extends Node2D

signal switch_scene(scene_key: String)


func _on_begin_pressed() -> void:
	switch_scene.emit("game")
