class_name Sun
extends Node3D

static var color_schemes: Array[Array] = [
	[Color.hex(0xcc5b09ff), Color.hex(0xff6a11ff), Color.hex(0xe68d1fff), Color.hex(0xfa2900ff), Color.hex(0xb3282cff)],
	[Color.hex(0x5a9330ff), Color.hex(0x2d6a11ff), Color.hex(0x3abda1ff), Color.hex(0x2097bdff), Color.hex(0x1460c4ff)],
	[Color.hex(0x253e95ff), Color.hex(0x4842bfff), Color.hex(0x6fb4a6ff), Color.hex(0x2097bdff), Color.hex(0x1460c4ff)],
	[Color.hex(0xe1e9fcff), Color.hex(0x030215ff), Color.hex(0x6fb4a6ff), Color.hex(0x2097bdff), Color.hex(0x1460c4ff)],
	[Color.hex(0xf3d900ff), Color.hex(0x273302ff), Color.hex(0xc7a018ff), Color.hex(0x9d865fff), Color.hex(0x6a6264ff)],
	[Color.hex(0x954994ff), Color.hex(0x550a30ff), Color.hex(0xd877eeff), Color.hex(0xeb4354ff), Color.hex(0xa31d95ff)],
]

var _scaling_factor := Vector3(0.25, 0.25, 0.25)

var space_type := "sun"

@export var capital: Capital
@export var is_first_sun: bool = false

@onready var build_manager: BuildManager = $BuildManager
@onready var _default_collision_radius: float = %CollisionShape3D.shape.radius
@onready var _universe: Universe = get_node("/root/Universe")

var _rotate: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("space_objects")
	add_to_group("suns")
	
	%Body.mesh = %Body.mesh.duplicate()
	%Atmosphere.mesh = %Atmosphere.mesh.duplicate()
	%Body.mesh.material = %Body.mesh.material.duplicate()
	#%Body.mesh.material.shader = %Body.mesh.material.shader.duplicate()
	%Atmosphere.mesh.material = %Atmosphere.mesh.material.duplicate()
	
	var shader_material: ShaderMaterial = %Body.mesh.material
	var colors: Array
	if is_first_sun:
		colors = color_schemes[0]
	else:
		colors = color_schemes.pick_random()
	shader_material.set_shader_parameter("color_1", colors[0])
	shader_material.set_shader_parameter("color_2", colors[1])
	shader_material.set_shader_parameter("color_3", colors[2])
	shader_material.set_shader_parameter("color_4", colors[3])
	shader_material.set_shader_parameter("color_5", colors[4])
	
	var atmosphere_material: StandardMaterial3D = %Atmosphere.mesh.material
	atmosphere_material.albedo_color = colors[0]
	atmosphere_material.albedo_color.a8 = 66
	
	%FakeStar.modulate = colors[0]
	
	rotate_x(randf_range(-0.1, 0.1))
	rotate_z(randf_range(-0.1, 0.1))
	
	%Aim.scale = Vector3(10, 10, 10)
	
	for i in range(randi_range(9, 17)):
		var planet_scene := preload("res://scenes/planet/terrestial_planet.tscn")
		_spawn_planet(planet_scene, 1.4, 1.8)
		
	for i in range(randi_range(2, 4)):
		var planet_scene := preload("res://scenes/planet/desert_planet.tscn")
		_spawn_planet(planet_scene, 1.0, 1.4)
	
	for i in range(randi_range(2, 4)):
		var planet_scene := preload("res://scenes/planet/desert_planet.tscn")
		_spawn_planet(planet_scene, 2.0, 2.5)
	
	for i in range(randi_range(4, 8)):
		var planet_scene := preload("res://scenes/planet/purple_planet.tscn")
		_spawn_planet(planet_scene, 1.5, 2.9)
		

func _spawn_planet(planet_scene: PackedScene, start: float, end: float):
	var planet: Node3D = planet_scene.instantiate()
	for try in range(0, 100):
		var random_direction = Vector3(randf_range(-1.0, 1.0), randf_range(-0.05, 0.05), randf_range(-1.0, 1.0)).normalized() * randf_range(start, end)
		planet.position = random_direction
		
		var too_close := false
		for c in get_children():
			if c is Planet:
				if c.position.distance_squared_to(planet.position) < 0.5 * 0.5:
					too_close = true
					break
		if too_close:
			continue
		
		planet.scale = Vector3(0.003, 0.003, 0.003)
		
		add_child(planet)
		break

func on_select():
	for c in get_children():
		if c is Planet:
			c.set_process(true)
			c.show()
			c.create_collision()
	
	$Body.show()
	$Atmosphere.show()
	
	%Aim.hide()
	%Aim.texture = preload("res://assets/aim_2.png")
	%FakeStar.hide()
	

func on_deselect():		
	for sun in get_tree().get_nodes_in_group("suns"):
		if sun != self:
			if _universe.interstellar:
				sun.get_node("Aim").show()
			else:
				sun.get_node("Aim").hide()
			
			sun.get_node("Body").hide()
			sun.get_node("Atmosphere").hide()
			sun.get_node("FakeStar").show()
			
			for c in sun.get_children():
				if c is Planet:
					c.set_process(false)
					c.hide()
					c.remove_collision()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$Body.rotate_y(0.004 * delta * Globals.speed)
	
	if _rotate:
		# Only rotates while zoomed out or else the camera jitters
		rotate_y(0.005 * delta * Globals.speed)
		$OmniLight3D.hide()
	else:
		if _universe.get_current_sun() == self:
			$OmniLight3D.show()
		else:
			$OmniLight3D.hide()
		

func _process(delta: float) -> void:
	if _universe.interstellar:
		var scale: Vector3 = _universe.space_objects_zoom.scale
		scale = _scaling_factor / scale
		%CollisionShape3D.shape.radius = scale.x / 2.0
		if %CollisionShape3D.shape.radius < _default_collision_radius:
			%CollisionShape3D.shape.radius = _default_collision_radius
		%Aim.scale = scale
