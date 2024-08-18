class_name Capital
extends Node

var owned_space_objects: Array[Node3D] = []

var capital = {
	"coins": 6000.0,
	"population": 4999.0,
	"ore": 0.0,
	"resources": 0.0,
	"energy": 0.0,
	"dark_matter": 0.0,
}

func update_capital():
	
	# Base gain of 100.0 coins per second
	capital["coins"] += 100.0
	
	for space_object: Node3D in owned_space_objects:
		space_object.build_manager.update_capital(self)

func _on_timer_timeout() -> void:
	for i in range(Globals.speed):
		update_capital()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cheat_coins"):
		capital["coins"] += 1000
