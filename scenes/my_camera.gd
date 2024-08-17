extends Node3D

@export_range(0.0, 2.0) var rotation_speed: float = PI/2

@export_range(1.0, 20.0) var move_speed: float = 12.0
@export_range(-10.0, 10.0) var y_offset: float = 0.0

# zoom settings
@export var max_zoom := 12.0
@export var min_zoom := 0.1
@export_range(0.05, 1.0) var zoom_speed := 0.125

# mouse settings
@export var mouse_control := true
@export_range(0.001, 0.1) var mouse_sensitivity := 0.005
@export var invert_y := false
@export var invert_x := false

@export var target: Node3D



var current_translation := Vector3(0, 0, 0)
var zoom = 1.5

@onready var inner_gimbal = $OuterGimbal/InnerGimbal
@onready var outer_gimbal = $OuterGimbal
@onready var the_camera: Camera3D = $OuterGimbal/InnerGimbal/ActualCamera

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#move_camera_with_keyboard(delta)
	inner_gimbal.rotation.x = clamp(inner_gimbal.rotation.x, -(PI/2), (PI/2) - 0.1)
	outer_gimbal.scale = lerp(outer_gimbal.scale, Vector3.ONE * zoom, zoom_speed)


func calc_zoom_factor() -> float:
	return pow(2, 0.26*zoom) - 0.8
	
	
func move_camera_with_keyboard(delta):
	if Input.is_action_pressed("cam_right"):
		current_translation.x = 1
	elif Input.is_action_pressed("cam_left"):
		current_translation.x = -1
	else:
		current_translation.x *= 0.85
	if Input.is_action_pressed("cam_forward"):
		current_translation.z = -1
	elif Input.is_action_pressed("cam_back"):
		current_translation.z = 1
	else:
		current_translation.z *= 0.85
	var translation_with_delta = Vector3(current_translation.x, current_translation.y, current_translation.z)
	if Input.is_action_pressed("cam_faster"):
		translation_with_delta *= 2

	var zoom_factor: float = calc_zoom_factor()
	translation_with_delta.x *= delta * move_speed * zoom_factor
	translation_with_delta.z *= delta * move_speed * zoom_factor
	if translation_with_delta.length() > 0.01:
		self.translate(translation_with_delta)

func _input(event):
	#if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
	#	return
	if Input.is_action_pressed("cam_rotate"):
		if mouse_control and event is InputEventMouseMotion:
			if event.relative.x != 0:
				var dir = 1 if invert_x else -1
				rotate_object_local(Vector3.UP, dir * event.relative.x * mouse_sensitivity)
			if event.relative.y != 0:
				var dir = 1 if invert_y else -1
				var y_rotation = clamp(event.relative.y, -30, 30)
				inner_gimbal.rotate_object_local(Vector3.RIGHT, dir * y_rotation * mouse_sensitivity)
