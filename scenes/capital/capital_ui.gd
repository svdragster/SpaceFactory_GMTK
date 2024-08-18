extends Control

@export var universe: Universe

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in $VBoxContainer.get_children():
		c.universe = universe
