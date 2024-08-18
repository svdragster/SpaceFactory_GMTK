class_name QuestManager
extends Node

@export var player: Node
@export var capital: Capital
@export var quest_ui: QuestUI

var current_quest: Node

var quest_scenes = {
	"QuestCity": preload("res://scenes/quest/quests/quest_city.tscn"),
	"QuestSpaceStation": preload("res://scenes/quest/quests/quest_space_station.tscn"),
}

func _ready() -> void:
	start_quest("QuestCity")
	

func start_quest(quest_key: String) -> void:
	if is_instance_valid(current_quest):
		current_quest.dispose()
		current_quest.queue_free()
	
	var new_quest_node = quest_scenes[quest_key].instantiate()
	new_quest_node.player = player
	new_quest_node.quest_manager = self
	add_child(new_quest_node)
	new_quest_node.start()
	current_quest = new_quest_node
	
	quest_ui.quest_name.text = current_quest.quest_name
	quest_ui.quest_description.text = current_quest.quest_desc
	
	
