class_name CapitalEntry
extends Control

@export var universe: Universe
@export var capital_key: String
@export var icon: Texture2D

func _ready() -> void:
	%Icon.texture = icon
	%Name.text = BuildingsSingleton.mappings[capital_key]
	%Diff.label_settings = %Diff.label_settings.duplicate(true)
	Globals.on_built_event.connect(func(p, u, v, w): update())


func update() -> void:
	var capital: Capital = universe.get_active_capital()
	var amount := int(capital.capital[capital_key])
	var diff = capital.capital_diff[capital_key]
	if abs(diff) <= 0.1:
		%Diff.text = ""
	elif diff > 0.0:
		%Diff.text = "+"
		if diff > 1000:
			%Diff.text = "+ + +"
		elif diff > 200:
			%Diff.text = "+ +"
		%Diff.label_settings.outline_color = Color.GREEN
		%Diff.label_settings.font_color = Color.GREEN
	elif diff < 0.0:
		%Diff.text = "-"
		if diff < -1000:
			%Diff.text = "- - -"
		elif diff < -200:
			%Diff.text = "- -"
		%Diff.label_settings.outline_color = Color.RED
		%Diff.label_settings.font_color = Color.RED
	%Amount.text = SpaceUtil.format_int(amount)


func _on_timer_timeout() -> void:
	update()
