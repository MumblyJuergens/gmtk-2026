# SceneManager.gd — Attach to your GameController or use as Autoload
# Inspired by of https://dredyson.com/the-hidden-truth-about-adding-and-removing-scenes-as-child-nodes-at-runtime-in-godot-4-7-insider-tips-gotchas-and-a-complete-step-by-step-guide-that-nobody-talks-about/
class_name SceneManager

var scene_holder: CanvasLayer
var current_scene: Node = null
var is_transitioning: bool = false

# Pre-load frequently used scenes
var cached_scenes: Dictionary[String, PackedScene] = {
	"menu": preload("res://menu/menu.tscn"),
	"game": preload("res://game/game.tscn"),
	"game_over": preload("uid://towljr3rwyv2"),
}


func _init(holder: CanvasLayer) -> void:
	scene_holder = holder
	# If SceneHolder has a default child, grab it
	if scene_holder != null and scene_holder.get_child_count() > 0:
		current_scene = scene_holder.get_child(0)


func switch_scene(scene_key: String) -> void:
	if is_transitioning:
		push_warning("SceneManager: Already transitioning, ignoring")
		return

	if not cached_scenes.has(scene_key):
		push_error("SceneManager: Unknown scene key: " + scene_key)
		return

	is_transitioning = true
	_perform_switch.call_deferred(cached_scenes[scene_key])


func switch_scene_from_path(path: String) -> void:
	if is_transitioning:
		push_warning("SceneManager: Already transitioning, ignoring")
		return

	var resource: Resource = ResourceLoader.load(path)
	if resource == null:
		push_error("SceneManager: Failed to load scene at path: " + path)
		return

	is_transitioning = true
	_perform_switch.call_deferred(resource)


func _perform_switch(resource: Resource) -> void:
	# Free current scene
	if current_scene != null:
		current_scene.queue_free()
		current_scene = null

	# Instance and add new scene
	current_scene = resource.instantiate()
	scene_holder.add_child(current_scene)
	if current_scene.has_signal("switch_scene"):
		current_scene.switch_scene.connect(switch_scene)

	is_transitioning = false
	print("SceneManager: Transition complete")
