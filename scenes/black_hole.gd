class_name BlackHole
extends Node3D

@onready var build_manager: BuildManager = $BuildManager

@onready var capital: Capital = %Capital

var space_type := "black_hole"

# Called when the node enters the scene tree for the first time.
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
	
func on_deselect():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
