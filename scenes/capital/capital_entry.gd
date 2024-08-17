class_name CapitalEntry
extends Control

@export var capital: Capital
@export var capital_key: String


func _ready() -> void:
	%Name.text = BuildingsSingleton.mappings[capital_key]


func update() -> void:
	var amount := int(capital.capital[capital_key])
	%Amount.text = SpaceUtil.format_int(amount)


func _on_timer_timeout() -> void:
	update()
