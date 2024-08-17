extends Control

@export var selected_space_object_type: String = "terrestial"
var show_build_menu := false

@onready var building_guis = {
	"terrestial": %TerrestialPlanetBuildingGui,
	"desert": %DesertPlanetBuildingGui,
	"sun": %SunPlanetBuildingGui,
	"black_hole": %BlackHolePlanetBuildingGui,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	
	if show_build_menu:
		building_guis[selected_space_object_type].show()
	
	
	
	
