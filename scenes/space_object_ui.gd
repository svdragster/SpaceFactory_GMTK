extends Control

@export var selected_space_object: Node3D
@export var player: Node
var show_build_menu := false

@onready var building_guis = {
	"terrestial": %TerrestialPlanetBuildingGui,
	"desert": %DesertPlanetBuildingGui,
	"sun": %SunPlanetBuildingGui,
	"black_hole": %BlackHolePlanetBuildingGui,
}

func _ready() -> void:
	pass

func _on_build_button_pressed() -> void:
	var all_hidden := true
	for v: Control in building_guis.values():
		if v.visible:
			all_hidden = false
	if all_hidden:
		show_build_menu = true
	else:
		show_build_menu = !show_build_menu
	update_build_menu()
	
func update_build_menu() -> void:
	for v: Control in building_guis.values():
		v.hide()
	
	var menu = building_guis[selected_space_object.space_type]
	var info_gui: InfoGui = menu.get_node("InfoGui")
	info_gui.on_build = on_build
	
	if show_build_menu:
		menu.show()

func on_build(build_key: String) -> int:
	var amount := 1
	if Input.is_action_pressed("buy_multiple"):
		amount = 10
		
	var result: Array[int] = player.get_node("PlayerBuildManager").on_build(build_key, selected_space_object, amount)
	var new_building_amount: int = result[0]
	var built_amount: int = result[1]
	
	if built_amount == 0:
		# TODO: play sound that nothing was built
		pass
	else:
		# TODO: play build sound
		pass
		
	return new_building_amount
	
	
	
	
