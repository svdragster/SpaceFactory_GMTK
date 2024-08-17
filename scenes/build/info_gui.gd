extends Control

@export var space_parent: Node3D
@export var on_build: Callable

var buttons: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_register_buttons_recursively(self)
		
func _register_buttons_recursively(node: Control):
	if node is BuildingButton:
		var button: BuildingButton = node
		var callback = Callable(
			_on_build
		)
		callback = callback.bindv([button.building_type])
		button.pressed.connect(callback)
		buttons[button.building_type] = button
		return
		
	for c in node.get_children():
		_register_buttons_recursively(c)

func _on_build(building_type: String) -> void:
	print("_on_build ", building_type)
	on_build.callv([building_type])
	
func update_button(building_type: String, amount: int) -> void:
	var button: BuildingButton = buttons[building_type]
	button.set_building_amount(amount)
