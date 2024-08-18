class_name BuildingButton
extends Button

@export var building_type: String = ""
@export var cost_factor: float = 1.0
@export var has_capital: bool = false


func _ready() -> void:
	%Requirements.label_settings = %Requirements.label_settings.duplicate(true)
	set_enabled_state(true)

func set_building_amount(amount: int) -> void:
	if building_type == "interstellar_travel":
		if get_node("/root/Universe").interstellar:
			set_enabled_state(false)
	%Name.text = BuildingsSingleton.mappings[building_type]
	%Name.text += " (" + str(amount) + ")"
	update_requirements()

func update_requirements() -> void:
	%Requirements.text = "Costs "
	for cost_name in BuildingsSingleton.all_buildings[building_type].keys():
		var cost_amount: int = BuildingsSingleton.all_buildings[building_type][cost_name] * cost_factor
		%Requirements.text += SpaceUtil.format_int(cost_amount)
		%Requirements.text += " "
		%Requirements.text += BuildingsSingleton.mappings[cost_name]
		%Requirements.text += ",\n"
	%Requirements.text = %Requirements.text.substr(0, %Requirements.text.length() - 2)
	if has_capital:
		%Requirements.label_settings.font_color = Color.GREEN_YELLOW
	else:
		%Requirements.label_settings.font_color = Color.ORANGE

func set_enabled_state(state: bool) -> void:
	if state:
		%Disabled.hide()
	else:
		%Disabled.show()
