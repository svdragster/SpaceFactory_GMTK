class_name Universe
extends Node3D

@export var max_zoom := 1000.0
@export var min_zoom := 0.01
@export_range(0.05, 1.0) var zoom_speed := 0.125
var zoom: float = 1.0

@onready var target: Node3D = %StartSun

@onready var space_objects_root: Node3D = $ObjectsZoom/Objects
@onready var space_objects_zoom: Node3D = $ObjectsZoom

var paused := true
var interplanetary := false
var interstellar := false

var _old_speed: int = Globals.speed

func _ready() -> void:
	for sun in get_tree().get_nodes_in_group("suns"):
		sun.capital = $PlayerData/Player1/Capital
		sun.on_deselect()
		
	get_active_capital().owned_space_objects.append(%StartPlanet)
	
	%StartSun.on_select()
	%StartSun.on_deselect()
	for p in %StartSun.get_children():
		if p is Planet:
			p.create_collision()
	
	zoom = 0.3
	space_objects_zoom.scale = Vector3(zoom, zoom, zoom)
	

func start() -> void:
	unpause()
	target = %StartPlanet
	select_object(%StartPlanet)
	
func pause() -> void:
	paused = true
	_old_speed = Globals.speed
	Globals.speed = 0
	%MainMenu.show()
	%SpaceObjectUI.hide()
	%CapitalUI.hide()
	%QuestUI.hide()
	%SpeedUI.hide()
	
func unpause() -> void:
	paused = false
	Globals.speed = _old_speed
	%MainMenu.hide()
	%SpaceObjectUI.show()
	%CapitalUI.show()
	%QuestUI.show()
	%SpeedUI.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not paused:
		space_objects_zoom.scale = lerp(space_objects_zoom.scale, Vector3(zoom, zoom, zoom), 10.0 * delta)
		if not Globals.disable_rays:
			handle_mouse()
		focus_target()

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
	var end: Vector3 = origin + camera.project_ray_normal(mousepos) * 100_000
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
			if collider_parent is Planet:
				if collider_parent.get_parent() == get_current_sun():
					select_object(collider_parent)
				elif interstellar:
					select_object(collider_parent.get_parent())
			elif collider_parent is Sun:
				if interstellar:
					select_object(collider_parent)
				if interplanetary and collider_parent == get_current_sun():
					select_object(collider_parent)
			elif collider_parent is BlackHole:	
				if interstellar:
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
			get_active_capital().capital["coins"] += 500
		elif collider is ClickableOres:
			collider.queue_free()
			get_active_capital().capital["ore"] += 10

func select_object(new_target: Node3D):
	var old_target = target
	old_target.on_deselect()
	target = new_target
	focus_target()
	target.on_select()
	
	if target.space_type == "terrestial":
		zoom = 582
	elif target.space_type == "desert":
		zoom = 700
	elif target.space_type == "sun":
		zoom = 2
	elif target.space_type == "black_hole":
		zoom = 0.42
	
	%SpaceObjectUI.selected_space_object = target
	%SpaceObjectUI.update_build_menu()
	Globals.on_object_select_event.emit(%PlayerData/Player1, target)

func focus_target():
	space_objects_root.global_position = Vector3.ZERO
	space_objects_root.global_position = -target.global_position
	
	var sun = get_current_sun()
	if is_instance_valid(sun):
		sun._rotate = zoom < 20

func calc_zoom_factor() -> float:
	return pow(zoom, 1.2)

func _input(event):
	if paused:
		return
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
			elif not interstellar:
				min_zoom_tmp = 0.5
			zoom = clamp(zoom, min_zoom_tmp, max_zoom)
			

func get_current_sun() -> Sun:
	if target is Sun:
		return target
	if target is Planet:
		if target.get_parent() is Sun:
			return target.get_parent()
	return null

func get_active_capital() -> Capital:
	return get_node("PlayerData/Player1/Capital")
	#if target is BlackHole:
	#	return target.capital
	#if target is Sun:
	#	return target.capital
	#var parent = target.get_parent()
	#if parent is Sun:
	#	return parent.capital
	#return null
