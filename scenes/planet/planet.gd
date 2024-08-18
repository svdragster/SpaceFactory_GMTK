class_name Planet
extends Node3D

@export var space_type := "unknown"

@onready var build_manager: BuildManager = $BuildManager

var _scaling_factor := Vector3(105.0, 105.0, 105.0)

@onready var _default_collision_radius: float = %CollisionShape3D.shape.radius
@onready var _universe = get_node("/root/Universe")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("space_objects")
	add_to_group("planets")
	
	rotate_x(randf_range(-0.6, 0.6))
	rotate_z(randf_range(-0.6, 0.6))
	
	%Aim.scale = Vector3(10, 10, 10)

func on_select():
	
	%CollisionShape3D.shape.radius = _default_collision_radius
	%Aim.hide()
	%Aim.texture = preload("res://assets/aim_2.png")

func on_deselect():
	%Aim.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MeshInstance3D.rotate_y(0.1 * delta * Globals.speed)
	
	var scale: Vector3 = _universe.space_objects_zoom.scale
	scale = _scaling_factor / scale
	%CollisionShape3D.shape.radius = scale.x / 2.0
	if %CollisionShape3D.shape.radius < _default_collision_radius:
		%CollisionShape3D.shape.radius = _default_collision_radius
	%Aim.scale = scale
