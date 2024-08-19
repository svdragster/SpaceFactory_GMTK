class_name QuestManager
extends Node

@export var player: Node
@export var quest_ui: QuestUI

var current_quest: Node

var quest_scenes = {
	"QuestCity": preload("res://scenes/quest/quests/quest_city.tscn"),
	"QuestSpaceStation": preload("res://scenes/quest/quests/quest_space_station.tscn"),
	"QuestOre": preload("res://scenes/quest/quests/quest_ore.tscn"),
	"QuestFactory": preload("res://scenes/quest/quests/quest_factory.tscn"),
	"QuestDysonSphere": preload("res://scenes/quest/quests/quest_dyson_sphere.tscn"),
	"QuestInterstellar": preload("res://scenes/quest/quests/quest_interstellar.tscn"),
	"QuestDarkMatter": preload("res://scenes/quest/quests/quest_dark_matter.tscn"),
}

func _ready() -> void:
	quest_ui.hide()
	
func start_first_quest():
	await get_tree().create_timer(3.0).timeout
	start_quest("QuestCity")

func _process(delta: float) -> void:
	if is_instance_valid(current_quest):
		quest_ui.show()
	else:
		quest_ui.hide()

func start_quest(quest_key: String) -> void:
	if is_instance_valid(current_quest):
		current_quest.dispose()
		current_quest.queue_free()
	
	Globals.on_attention_sound.emit()
	
	var new_quest_node = quest_scenes[quest_key].instantiate()
	new_quest_node.player = player
	new_quest_node.quest_manager = self
	add_child(new_quest_node)
	new_quest_node.start()
	current_quest = new_quest_node
	
	quest_ui.show()
	quest_ui.quest_name.text = current_quest.quest_name
	quest_ui.quest_description.text = current_quest.quest_desc
	quest_ui.highlight()
	
	
