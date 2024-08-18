class_name Planet
extends Node3D

@export var space_type := "unknown"

@onready var build_manager: BuildManager = $BuildManager

var light: OmniLight3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("space_objects")
	add_to_group("planets")
	
	rotate_x(randf_range(-0.6, 0.6))
	rotate_z(randf_range(-0.6, 0.6))

func on_select():
	var sun = get_parent()
	if is_instance_valid(light):
		light.queue_free()
	light = OmniLight3D.new()
	light.position = global_position.direction_to(sun.global_position) * 5
	light.omni_range = 20.0
	light.light_energy = 10.0
	add_child(light)

func on_deselect():
	if is_instance_valid(light):
		light.queue_free()
		light = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MeshInstance3D.rotate_y(0.1 * delta * Globals.speed)
