extends Node3D

@export var max_zoom := 1000.0
@export var min_zoom := 0.1
@export_range(0.05, 1.0) var zoom_speed := 0.125
var zoom: float = 1.0

@onready var target: Node3D

@onready var space_objects_root: Node3D = $ObjectsZoom/Objects
@onready var space_objects_zoom: Node3D = $ObjectsZoom


var interplanetary := false
var interstellar := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_tree().get_nodes_in_group("space_objects")[2]
	select_object(target)
	
	%PlayerData/Player1/Capital.owned_space_objects.append(target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	space_objects_zoom.scale = lerp(space_objects_zoom.scale, Vector3(zoom, zoom, zoom), 10.0 * delta)
	if not Globals.disable_rays:
		handle_mouse()

func handle_mouse():
	if Input.is_action_just_pressed("select"):
		# New targets can only be selected after building a space station
		handle_click_space_objects()
		handle_clickables()

func handle_click_space_objects():
	var camera: Camera3D = get_viewport().get_camera_3d()
	var space_state := get_world_3d().direct_space_state

	var mousepos: Vector2 = get_viewport().get_mouse_position()

	var origin: Vector3 = camera.project_ray_origin(mousepos)
	var end: Vector3 = origin + camera.project_ray_normal(mousepos) * 1000
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	query.collision_mask = 1

	var result: Dictionary = space_state.intersect_ray(query)
	if result.size() > 0:
		var collider = result["collider"]
		var collider_parent = collider.get_parent()
		if collider_parent != target:
			if not interplanetary:
				return
			var allowed := ["terrestial", "desert", "purple", "sun"]
			if interstellar:
				allowed.append_array(["black_hole"])
			if not collider_parent.space_type in allowed:
				return
			select_object(collider_parent)
			
func handle_clickables():
	var camera: Camera3D = get_viewport().get_camera_3d()
	var space_state := get_world_3d().direct_space_state

	var mousepos: Vector2 = get_viewport().get_mouse_position()

	var origin: Vector3 = camera.project_ray_origin(mousepos)
	var end: Vector3 = origin + camera.project_ray_normal(mousepos) * 10
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	query.collision_mask = 2

	var result: Dictionary = space_state.intersect_ray(query)
	if result.size() > 0:
		var collider = result["collider"]
		if collider is ClickableCoins:
			collider.queue_free()
			%PlayerData/Player1/Capital.capital["coins"] += 500
		elif collider is ClickableOres:
			collider.queue_free()
			%PlayerData/Player1/Capital.capital["ore"] += 10

func select_object(new_target: Node3D):
	var old_target = target
	old_target.on_deselect()
	target = new_target
	space_objects_root.global_position = Vector3.ZERO
	space_objects_root.global_position = -target.global_position
	target.on_select()
	
	if target.space_type == "terrestial":
		zoom = 582
	elif target.space_type == "desert":
		zoom = 700
	elif target.space_type == "sun":
		zoom = 5.8
	elif target.space_type == "black_hole":
		zoom = 3
	
	%SpaceObjectUI.selected_space_object = target
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
			
			var min_zoom_tmp := min_zoom
			if not interplanetary:
				min_zoom_tmp = 400
			if not interstellar:
				min_zoom_tmp = 4
			zoom = clamp(zoom, min_zoom_tmp, max_zoom)

func scale_universe():
	pass
