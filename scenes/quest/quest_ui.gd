class_name QuestUI
extends Control

@onready var quest_name: Label =  %Name
@onready var quest_description: Label =  %Description


func _on_pause_pressed() -> void:
	get_node("/root/Universe").pause()
