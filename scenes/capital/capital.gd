class_name Capital
extends Node

var owned_space_objects: Array[Node3D] = []

#var capital = {
#	"coins": 6000.0,
#	"population": 4999.0,
#	"ore": 0.0,
#	"resources": 0.0,
#	"energy": 0.0,
#	"dark_matter": 0.0,
#}

var capital = {
	"coins": 1_000_000.0,
	"population": 1_000_000.0,
	"ore": 1_000_000.0,
	"resources": 1_000_000.0,
	"energy": 200_000.0,
	"dark_matter": 0.0,
}

var capital_old: Dictionary

var capital_diff = {
	"coins": 0.0,
	"population": 0.0,
	"ore": 0.0,
	"resources": 0.0,
	"energy": 0.0,
	"dark_matter": 0.0,
}

func update_capital():
	
	capital_old = capital.duplicate(true)
	
	# Base gain of 120.0 coins per second
	capital["coins"] += 120.0
	
	for space_object: Node3D in owned_space_objects:
		space_object.build_manager.update_capital(self)
	
	for capital_key: String in capital.keys():
		var capital_amount: float = capital[capital_key]
		var diff: float = capital_amount - capital_old[capital_key]
		capital_diff[capital_key] = diff

func _on_timer_timeout() -> void:
	for i in range(Globals.speed):
		update_capital()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cheat_coins"):
		capital["coins"] += 5000
