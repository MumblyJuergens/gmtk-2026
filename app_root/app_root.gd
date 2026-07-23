class_name AppRoot
extends Node2D

@export var editor_scene: PackedScene
@onready var scene_holder: CanvasLayer = $SceneHolder
var scene_manager: SceneManager

func _ready() -> void:
	# Just until we get them menu running.
	scene_manager = SceneManager.new(scene_holder)
	scene_manager.switch_scene("menu")
