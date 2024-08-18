class_name QuestOre
extends Node

@export var player: Node
@export var quest_manager: QuestManager

var quest_name = "Mine Ore"
var quest_desc = "Go to a desert or purple planet and build a mine.\n\nZoom out and click on another planet to build on it."
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
	if building_type == "mine":
		done = true
		quest_manager.start_quest("QuestFactory")
		
