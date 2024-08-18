class_name QuestSpaceStation
extends Node

@export var player: Node
@export var quest_manager: QuestManager

var quest_name = "Enter the Orbit"
var quest_desc = "After growing your population, build a Space Station to reach other planets."
var done := false

func start():
	Globals.on_built_event.connect(_on_built_event_listener)

func dispose():
	Globals.on_built_event.disconnect(_on_built_event_listener)

func update():
	pass

func _on_built_event_listener(player: Node, building_type: String, amount: int) -> void:
	if done:
		return
	if building_type == "space_station":
		done = true
		get_node("/root/Universe").zoom = 100
		get_node("/root/Universe").interplanetary = true
		#quest_manager.start_quest("QuestConquerPlanet")
		
