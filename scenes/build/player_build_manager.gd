class_name PlayerBuildManager
extends Node

@export var player: Node
@export var capital: Capital

func on_build(building_type: String, space_object: Node3D, amount_requested: int) -> Array[int]:
	# Object must be owned by player or have a space station in order to build new buildings
	if not space_object in capital.owned_space_objects:
		if building_type != "space_station":
			return [0, 0]
	
	var costs: Dictionary = BuildingsSingleton.all_buildings[building_type]
	var new_building_amount: int = space_object.build_manager.buildings.get(building_type, 0)
	var built_amount := 0
	var has_capital: bool = true
	for i in range(amount_requested):
		
		# First check that player has enough capital to build		
		if not has_capital_for_building(building_type):
			break
			
		# Only then remove capital
		for cost_key in costs.keys():
			var cost_amount = costs[cost_key]
			capital.capital[cost_key] -= cost_amount
			
		# Finally, build it
		new_building_amount = space_object.build_manager.build(building_type, 1)
		built_amount += 1
	
	if built_amount > 0:
		Globals.on_built_event.emit(player, building_type, built_amount)
		if building_type == "space_station":
			if not space_object in capital.owned_space_objects:
				capital.owned_space_objects.append(space_object)
	
	return [new_building_amount, built_amount]

func has_capital_for_building(building_type: String) -> bool:
	var costs: Dictionary = BuildingsSingleton.all_buildings[building_type]
	for cost_key in costs.keys():
		var capital_amount = capital.capital[cost_key]
		var cost_amount = costs[cost_key]
		if capital_amount < cost_amount:
			print("Not enough ", cost_key)
			return false
	return true
	
