class_name QuestDarkMatter
extends Node

@export var player: Node
@export var quest_manager: QuestManager

var quest_name = "Transcend Science"
var quest_desc = "Reach 100,000 Dark Matter to win the game!\n\nClick on other stars to colonize them."
var done := false

func start():
	pass

func dispose():
	pass

func update():
	if not done:
		var capital: Capital = get_node("/root/Universe").get_active_capital()
		if capital.capital["dark_matter"] >= 100_000:
			done = true
			print("WIN!")
			# TODO win screen

func _process(delta: float) -> void:
	update()

		
