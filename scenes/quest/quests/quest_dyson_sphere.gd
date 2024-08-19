class_name QuestDysonSphere
extends Node

@export var player: Node
@export var quest_manager: QuestManager

var quest_name = "Dyson Sphere Program"
var quest_desc = "Harvest the energy from the sun.\n\nClick on the sun to build in its orbit. However, you will need a lot of resources first."
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
	if building_type == "dyson_sphere":
		done = true
		quest_manager.start_quest("QuestInterstellar")
		
