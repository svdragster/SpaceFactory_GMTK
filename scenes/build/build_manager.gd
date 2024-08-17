extends Node3D

var buildings = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func build(building_type: String):
	if building_type not in BuildingsSingleton.all_buildings:
		return
	var cost = BuildingsSingleton.all_buildings[building_type]
	if not buildings.has(building_type):
		buildings[building_type] = 0
	buildings[building_type] += 1
	
func update_capital(capital: Capital):
	for building_type in buildings.keys():
		var amount = buildings[building_type]
		for generated_capital_type in BuildingsSingleton.production.keys():
			var generated_amount = BuildingsSingleton.production[generated_capital_type]
			capital.capital[generated_capital_type] += generated_amount
	
