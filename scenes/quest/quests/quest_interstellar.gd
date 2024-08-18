class_name QuestInterstellar
extends Node

@export var player: Node
@export var quest_manager: QuestManager

var quest_name = "Go Interstellar"
var quest_desc = "Follow the steps of Christopher and Jonathan Nolan and unlock interstellar travel."
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
	if building_type == "interstellar_travel":
		done = true
		get_node("/root/Universe").zoom = 0.2
		get_node("/root/Universe").interstellar = true
		
		for sun in get_tree().get_nodes_in_group("suns"):
			if sun != self:
				sun.get_node("Aim").show()
		
		quest_manager.start_quest("QuestDarkMatter")
		
