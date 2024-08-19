class_name BlackHole
extends Node3D

@onready var _universe: Universe = get_node("/root/Universe")
@onready var build_manager: BuildManager = $BuildManager

var _scaling_factor := Vector3(0.08, 0.08, 0.08)

@export var capital: Capital

var space_type := "black_hole"

func _ready() -> void:
	add_to_group("space_objects")
	add_to_group("black_holes")

func on_select():
	for sun in get_tree().get_nodes_in_group("suns"):
		sun.get_node("Aim").show()
		
		sun.get_node("Body").hide()
		sun.get_node("Atmosphere").hide()
		sun.get_node("FakeStar").show()
		
		for c in sun.get_children():
			if c is Planet:
				c.set_process(false)
				c.hide()
				c.remove_collision()
	
func on_deselect():
	pass

func _process(delta: float) -> void:
	if _universe.interstellar:
		var scale: Vector3 = _universe.space_objects_zoom.scale
		scale = _scaling_factor / scale
		%Aim.scale = scale
