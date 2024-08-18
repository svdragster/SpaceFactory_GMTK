class_name BuildManager
extends Node3D

var buildings = {}

func _ready() -> void:
	pass

func build(building_type: String, amount: int) -> int:
	if building_type not in BuildingsSingleton.all_buildings.keys():
		return 0
	if not buildings.has(building_type):
		buildings[building_type] = 0
	buildings[building_type] += amount
	return buildings[building_type]
	
func update_capital(capital: Capital):
	for building_type in buildings.keys():
		var amount = buildings[building_type]
		var can_gain = true
		
		# First, check if all costs are covered
		for generated_capital_type in BuildingsSingleton.production[building_type].keys():
			var generated_amount = BuildingsSingleton.production[building_type][generated_capital_type]
			if generated_amount < 0.0:
				var new_amount = capital.capital[generated_capital_type] + generated_amount * amount
				if new_amount < 0.0:
					can_gain = false
					break
					
		if can_gain:
			for generated_capital_type in BuildingsSingleton.production[building_type].keys():
				var generated_amount = BuildingsSingleton.production[building_type][generated_capital_type]
				capital.capital[generated_capital_type] += generated_amount * amount
	
