extends Node3D

@export var max_zoom := 1000.0
@export var min_zoom := 0.1
@export_range(0.05, 1.0) var zoom_speed := 0.125
var zoom: float = 1.0

@onready var target: Node3D = $ObjectsZoom/Objects/BlackHole
var target_index: int = 0

@onready var space_objects_root: Node3D = $ObjectsZoom/Objects
@onready var space_objects_zoom: Node3D = $ObjectsZoom

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	space_objects_zoom.scale = lerp(space_objects_zoom.scale, Vector3(zoom, zoom, zoom), 0.2)
	if Input.is_action_just_pressed("next_object"):
		var space_objects = get_tree().get_nodes_in_group("space_objects")
		target_index += 1
		if target_index >= space_objects.size():
			target_index = 0
		var old_target = space_objects[target_index]
		old_target.on_deselect()
		target = space_objects[target_index]
		space_objects_root.global_position = Vector3.ZERO
		space_objects_root.global_position = -target.global_position
		target.on_select()
		
		%SpaceObjectUI.selected_space_object_type = target.space_type
		%SpaceObjectUI.update_build_menu()
		

func calc_zoom_factor() -> float:
	return pow(zoom, 1.2)

func _input(event):
	if event is InputEventMouseButton:
		var camera_zoom_factor: float = calc_zoom_factor()
		if event.is_pressed():
			var zoom_factor = camera_zoom_factor
			if Input.is_action_pressed("cam_faster"):
				zoom_factor *= 2
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom += zoom_speed * zoom_factor
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom -= zoom_speed * zoom_factor
			zoom = clamp(zoom, min_zoom, max_zoom)

func scale_universe():
	pass
