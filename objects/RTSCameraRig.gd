extends Spatial
# An RTS-like camera rig.

# In units per second.
export(float, 0.1, 10) var camera_move_speed := 2.0
# In degrees per second per "pixel moved by the mouse".
export(float, 0.1, 360) var camera_rotation_speed := 45

export(float, -90, 0) var min_rotation_angle := -85
export(float, -90, 0) var max_rotation_angle := -5

# In units per second per tick of the scroll wheel. Scales by zoom distance.
export(float, 0.1, 10) var camera_zoom_speed := 5
export(float, 0, 10) var camera_min_distance := 1
export(float, 0, 10) var camera_max_distance := 5


onready var yaw_object := self
onready var pitch_object := $Pitch
onready var camera := $Pitch/Camera

var rotation_pressed := false
var camera_rotation := Vector2()
var camera_zoom := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# ---- Camera movement ----
	var camera_movement := Vector3()
	
	camera_movement.z = Input.get_action_strength("camera_back") - Input.get_action_strength("camera_forward")
	camera_movement.x = Input.get_action_strength("camera_right") - Input.get_action_strength("camera_left")
	
	self.translate(camera_movement * camera_move_speed * delta)
	
	# ---- /Camera movement ----
	
	# ---- Camera rotation ----
	
	yaw_object.rotate_y(-camera_rotation.x * deg2rad(camera_rotation_speed) * delta)
	pitch_object.rotate_x(-camera_rotation.y * deg2rad(camera_rotation_speed) * delta)
	
	# Limit pitch.
	pitch_object.rotation_degrees.x = clamp(pitch_object.rotation_degrees.x, min_rotation_angle, max_rotation_angle)
	
	# Camera rotation input is only valid 1 frame, so we reset it after use.
	camera_rotation = Vector2()
	
	# ---- /Camera rotation ----
	
	# ---- Camera zoom ----
	
	var current_zoom = camera.translation.z
	# Scale zoom speed with current zoom.
	var scaled_zoom_speed = camera_zoom_speed * current_zoom
	camera.translate(Vector3(0, 0, camera_zoom * scaled_zoom_speed * delta))
	
	# Limit camera zoom.
	camera.translation.z = clamp(camera.translation.z, camera_min_distance, camera_max_distance)
	
	# Camera zoom input is only valid for 1 frame, so reset after use.
	camera_zoom = 0.0
	
	# ---- /Camera zoom ----

func _unhandled_input(event):
	# ---- Camera rotation ----
	
	if event.is_action_pressed("camera_rotate"):
		rotation_pressed = true
	elif event.is_action_released("camera_rotate"):
		rotation_pressed = false
	
	if event is InputEventMouseMotion and rotation_pressed:
		camera_rotation = event.get_relative()
	
	# ---- /Camera rotation ----
	
	# ---- Camera zoom ----
	
	if event.is_action_pressed("camera_zoom_in") or event.is_action_pressed("camera_zoom_out"):
		camera_zoom = Input.get_action_strength("camera_zoom_out") - Input.get_action_strength("camera_zoom_in")
	
	# ---- /Camera zoom ----