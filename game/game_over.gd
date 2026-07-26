class_name GameOver
extends Control

signal switch_scene(key: String)
@onready var rich_text_label: RichTextLabel = $MarginContainer/Panel/MarginContainer/VBoxContainer/RichTextLabel


func _ready() -> void:
	var result: String = "won" if SharedJunk.last_result else "lost"
	rich_text_label.text = "You [color=ff0000]%s[/color]!\nThanks for playing!" % [result]


func _on_button_pressed() -> void:
	switch_scene.emit("game")
