class_name InfoGui
extends Control

@export var space_parent: Node3D
@export var on_build: Callable

var buttons: Dictionary = {}

var _old_buy_factor := Globals.buy_factor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_register_buttons_recursively(self)
	%One.add_theme_color_override("font_outline_color", Color.BLUE)
	%Ten.add_theme_color_override("font_outline_color", Color.BLUE)
	%Hundred.add_theme_color_override("font_outline_color", Color.BLUE)
	
	Globals.on_object_select_event.connect(
		func(player, space_object): 
			update_all_buttons(space_object)
			space_parent = space_object
	)
	Globals.on_built_event.connect(func(player, space_object, build_type, amount): update_all_buttons(space_object))

func _process(delta: float) -> void:
	if visible:
		if Input.is_action_just_pressed("buy_multiple"):
			_old_buy_factor = Globals.buy_factor
			Globals.buy_factor = 100
		elif Input.is_action_just_released("buy_multiple"):
			Globals.buy_factor = _old_buy_factor
		
		if Globals.buy_factor == 1:
			%One.add_theme_constant_override("outline_size", 6)
			%Ten.add_theme_constant_override("outline_size", 0)
			%Hundred.add_theme_constant_override("outline_size", 0)
		elif Globals.buy_factor == 10:
			%One.add_theme_constant_override("outline_size", 0)
			%Ten.add_theme_constant_override("outline_size", 6)
			%Hundred.add_theme_constant_override("outline_size", 0)
		elif Globals.buy_factor == 100:
			%One.add_theme_constant_override("outline_size", 0)
			%Ten.add_theme_constant_override("outline_size", 0)
			%Hundred.add_theme_constant_override("outline_size", 6)

func _register_buttons_recursively(node: Control):
	if node is BuildingButton:
		var button: BuildingButton = node
		var callback = Callable(
			_on_build
		)
		callback = callback.bindv([button.building_type])
		button.pressed.connect(callback)
		buttons[button.building_type] = button
		button.mouse_entered.connect(_on_mouse_enter)
		button.mouse_exited.connect(_on_mouse_exit)
		return
		
	for c in node.get_children():
		if c is Control:
			_register_buttons_recursively(c)

func _on_build(building_type: String) -> void:
	#var new_amount: int = on_build.callv([building_type])
	on_build.callv([building_type])
	
	
#func update_button(space_object: Node3D, building_type: String, amount: int) -> void:
#	var button: BuildingButton = buttons[building_type]
#	button.cost_factor = space_object.build_manager.calculate_cost_factor(building_type)
#	button.set_building_amount(amount)

func update_all_buttons(space_object: Node3D) -> void:
	var capital: Capital = get_node("/root/Universe").get_active_capital()
	var player_build_manager: PlayerBuildManager = get_node("/root/Universe/PlayerData/Player1/PlayerBuildManager")
	for button in buttons.values():
		if button.building_type != "":
			button.cost_factor = space_object.build_manager.calculate_cost_factor(button.building_type)
			var can_build: bool = player_build_manager.has_capital_for_building(capital, button.building_type, button.cost_factor, 1)
			button.set_building_amount(0)
			button.has_capital = can_build
	for building_type in space_object.build_manager.buildings:
		if building_type in buttons:
			var button: BuildingButton = buttons[building_type]
			button.cost_factor = space_object.build_manager.calculate_cost_factor(building_type)
			var can_build: bool = player_build_manager.has_capital_for_building(capital, building_type, button.cost_factor, 1)
			button.set_building_amount(space_object.build_manager.buildings[building_type])
			button.has_capital = can_build
	if space_object is Planet:
		if space_object in capital.owned_space_objects:
			for button: BuildingButton in buttons.values():
				button.set_enabled_state(true)
		else:
			for button: BuildingButton in buttons.values():
				if button.building_type != "space_station":
					button.set_enabled_state(false)
				else:
					button.set_enabled_state(true)
	else:
		for button: BuildingButton in buttons.values():
			button.set_enabled_state(true)
					

func _on_close() -> void:
	get_parent().hide()


# Annoying workaround bullshit to prevent clicking through GUI
func _on_mouse_enter() -> void:
	Globals.disable_rays = true

func _on_mouse_exit() -> void:
	Globals.disable_rays = false


func _on_one_pressed() -> void:
	Globals.buy_factor = 1


func _on_ten_pressed() -> void:
	Globals.buy_factor = 10


func _on_hundred_pressed() -> void:
	Globals.buy_factor = 100


func _on_timer_timeout() -> void:
	if is_instance_valid(space_parent):
		update_all_buttons(space_parent)
