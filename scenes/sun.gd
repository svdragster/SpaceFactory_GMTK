class_name Sun
extends Node3D


@onready var build_manager: BuildManager = $BuildManager

var space_type := "sun"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("space_objects")
	add_to_group("suns")

func on_select():
	pass

func on_deselect():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
