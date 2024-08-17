class_name Planet
extends Node3D

var id: int = -1

var light: OmniLight3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("space_objects")
	add_to_group("planets")

func on_select():
	var sun = get_parent()
	if is_instance_valid(light):
		light.queue_free()
	light = OmniLight3D.new()
	light.position = global_position.direction_to(sun.global_position) * 5
	light.omni_range = 100.0
	add_child(light)

func on_deselect():
	if is_instance_valid(light):
		light.queue_free()
		light = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
