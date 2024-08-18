class_name Planet
extends Node3D

@export var space_type := "unknown"

@onready var build_manager: BuildManager = $BuildManager

var _scaling_factor := Vector3(105.0, 105.0, 105.0)

@onready var _default_collision_radius: float = %CollisionShape3D.shape.radius
@onready var _universe = get_node("/root/Universe")

var _default_collision: Area3D
var _default_clickables: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("space_objects")
	add_to_group("planets")
	
	rotate_x(randf_range(-0.6, 0.6))
	rotate_z(randf_range(-0.6, 0.6))
	
	%Aim.scale = Vector3(10, 10, 10)
	
	remove_collision()

func create_collision():
	if not has_node("Area3D"):
		_default_collision.name = "Area3D"
		add_child(_default_collision)

func remove_collision():
	if has_node("Area3D"):
		_default_collision = get_node("Area3D")
		remove_child(_default_collision)
	
	if has_node("MeshInstance3D/Clickables"):
		_default_clickables = get_node("MeshInstance3D/Clickables")
		get_node("MeshInstance3D").remove_child(_default_clickables)

func on_select():
	
	%Aim.hide()
	%Aim.texture = preload("res://assets/aim_2.png")
	
	if not has_node("MeshInstance3D/Clickables"):
		_default_clickables.name = "Clickables"
		get_node("MeshInstance3D").add_child(_default_clickables)

func on_deselect():
	%Aim.show()
	
	if has_node("MeshInstance3D/Clickables"):
		_default_clickables = get_node("MeshInstance3D/Clickables")
		get_node("MeshInstance3D").remove_child(_default_clickables)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MeshInstance3D.rotate_y(0.1 * delta * Globals.speed)
	
	var _scale: Vector3 = _universe.space_objects_zoom.scale
	%Aim.scale = _scaling_factor / _scale
	if has_node("Area3D"):
		var area: Area3D = get_node("Area3D")
		if has_node("Area3D/CollisionShape3D"):
			var c: CollisionShape3D = get_node("Area3D/CollisionShape3D")
			c.shape.radius = 50.0 / _scale.x
			if c.shape.radius < _default_collision_radius:
				c.shape.radius = _default_collision_radius
		
	if _universe.zoom < 2.0:
		%Aim.modulate.a = _universe.zoom/2.0
