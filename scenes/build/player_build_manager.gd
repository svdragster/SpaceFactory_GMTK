class_name PlayerBuildManager
extends Node

@export var player: Node
@export var universe: Universe

func on_build(building_type: String, space_object: Node3D, amount_requested: int) -> Array[int]:
	var capital: Capital = universe.get_active_capital()
	
	# Object must be owned by player or have a space station in order to build new buildings
	if not space_object in capital.owned_space_objects:
		if building_type != "space_station":
			return [0, 0]
			
	
	var costs: Dictionary = BuildingsSingleton.all_buildings[building_type]
	var cost_factor: float = space_object.build_manager.calculate_cost_factor(building_type)
	var new_building_amount: int = space_object.build_manager.buildings.get(building_type, 0)
	var built_amount := 0
	var has_capital: bool = true
	
	if building_type == "space_station":
		amount_requested = 1
		if new_building_amount > 0:
			return [1, 0]
	
	if building_type == "interstellar_travel":
		amount_requested = 1
		if new_building_amount > 0:
			return [1, 0]
	
	for i in range(amount_requested):
		
		# First check that player has enough capital to build		
		if not has_capital_for_building(capital, building_type, cost_factor, 1):
			print("Not enough for ", building_type)
			break
			
		# Only then remove capital
		for cost_key in costs.keys():
			var cost_amount = costs[cost_key] * cost_factor
			capital.capital[cost_key] -= cost_amount
			
		# Finally, build it
		new_building_amount = space_object.build_manager.build(building_type, 1)
		built_amount += 1
		
	
	if built_amount > 0:
		Globals.on_built_event.emit(player, space_object, building_type, built_amount)
		if space_object is Planet:
			if building_type == "space_station":
				if not space_object in capital.owned_space_objects:
					capital.owned_space_objects.append(space_object)
		elif space_object is Sun or space_object is BlackHole:
			if not space_object in capital.owned_space_objects:
				capital.owned_space_objects.append(space_object)
	
	return [new_building_amount, built_amount]

func has_capital_for_building(capital: Capital, building_type: String, cost_factor: float, amount: int) -> bool:
	if building_type == "city":
		# Cities can always be built even without coins
		# or else it would be possible to run out of coins and not build any cities.
		# However only if the player earns less than 60 coins per second.
		if capital.capital["coins"] < 600 and capital.capital_diff["coins"] < 60.0:
			return true
	var costs: Dictionary = BuildingsSingleton.all_buildings[building_type]
	for cost_key in costs.keys():
		var capital_amount = capital.capital[cost_key]
		var cost_amount = costs[cost_key] * cost_factor * amount
		if capital_amount < cost_amount:
			return false
	return true
