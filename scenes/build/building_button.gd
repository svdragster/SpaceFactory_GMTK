class_name BuildingButton
extends Button

@export var building_type: String = ""



func _ready() -> void:
	if building_type != "":
		set_building_amount(0)
		for cost_name in BuildingsSingleton.all_buildings[building_type].keys():
			var cost_amount: int = BuildingsSingleton.all_buildings[building_type][cost_name]
			%Requirements.text += SpaceUtil.format_int(cost_amount)
			%Requirements.text += " "
			%Requirements.text += BuildingsSingleton.mappings[cost_name]
			%Requirements.text += ",\n"
		%Requirements.text = %Requirements.text.substr(0, %Requirements.text.length() - 2)

func set_building_amount(amount: int) -> void:
	%Name.text = BuildingsSingleton.mappings[building_type]
	%Name.text += " (" + str(amount) + ")"
