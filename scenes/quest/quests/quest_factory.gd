class_name QuestFactory
extends Node

@export var player: Node
@export var quest_manager: QuestManager

var quest_name = "Factorio"
var quest_desc = "Build a factory on a terrestial planet."
var done := false

func start():
	Globals.on_built_event.connect(_on_built_event_listener)

func dispose():
	Globals.on_built_event.disconnect(_on_built_event_listener)

func update():
	pass

func _on_built_event_listener(player: Node, space_object: Node3D, building_type: String, amount: int) -> void:
	if done:
		return
	if building_type == "factory":
		done = true
		quest_manager.start_quest("QuestDysonSphere")
		
