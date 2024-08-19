class_name QuestUI
extends Control

@onready var quest_name: Label =  %Name
@onready var quest_description: Label =  %Description


func _on_pause_pressed() -> void:
	get_node("/root/Universe").pause()

func highlight() -> void:
	%Timer.start()
	%Panel.self_modulate = Color.RED
	await get_tree().create_timer(4.0).timeout
	%Timer.stop()
	%Panel.self_modulate = Color.WHITE


func _on_timer_timeout() -> void:
	if %Panel.self_modulate == Color.RED:
		%Panel.self_modulate = Color.WHITE
	else:
		%Panel.self_modulate = Color.RED
