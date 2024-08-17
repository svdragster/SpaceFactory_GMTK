class_name BuildingButton
extends Button

@export var building_type: String = ""

func format(n):
	n = str(n)
	var size = n.length()
	var s = ""
	
	for i in range(size):
			if((size - i) % 3 == 0 and i > 0):
				s = str(s,",", n[i])
			else:
				s = str(s,n[i])
			
	return s

func _ready() -> void:
	if building_type != "":
		set_building_amount(0)
		for cost_name in BuildingsSingleton.all_buildings[building_type].keys():
			var cost_amount: int = BuildingsSingleton.all_buildings[building_type][cost_name]
			%Requirements.text += format(cost_amount)
			%Requirements.text += " "
			%Requirements.text += BuildingsSingleton.mappings[cost_name]
			%Requirements.text += ",\n"
		%Requirements.text = %Requirements.text.substr(0, %Requirements.text.length() - 2)

func set_building_amount(amount: int) -> void:
	%Name.text = BuildingsSingleton.mappings[building_type]
	%Name.text += " (" + str(amount) + ")"
