extends Spatial

# In units per second.
export(float, 0, 10) var camera_speed := 2.0
# In degrees per second per "pixel moved by the mouse".
export(float, 0, 360) var camera_rotation_speed := 45

export(float, -90, 0) var min_rotation_angle := -85
export(float, -90, 0) var max_rotation_angle := -5

onready var yaw_object = self
onready var pitch_object = $Pitch

var rotation_pressed := false
var camera_rotation := Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# ---- Camera movement ----
	var camera_movement := Vector3()
	
	camera_movement.z = Input.get_action_strength("camera_back") - Input.get_action_strength("camera_forward")
	camera_movement.x = Input.get_action_strength("camera_right") - Input.get_action_strength("camera_left")
	
	self.translate(camera_movement * camera_speed * delta)
	
	# ---- /Camera movement ----
	
	# ---- Camera rotation ----
	
	yaw_object.rotate_y(camera_rotation.x * deg2rad(camera_rotation_speed) * delta)
	pitch_object.rotate_x(camera_rotation.y * deg2rad(camera_rotation_speed) * delta)
	
	# Limit pitch.
	if pitch_object.rotation_degrees.x <= min_rotation_angle:
		pitch_object.rotation_degrees.x = min_rotation_angle
	elif pitch_object.rotation_degrees.x >= max_rotation_angle:
		pitch_object.rotation_degrees.x = max_rotation_angle
		
	
	# Camera rotation input is only valid 1 frame, so we reset it after use.
	camera_rotation = Vector2()
	
	# ---- /Camera rotation ----

func _input(event):
	# ---- Camera rotation ----
	
	if event.is_action_pressed("camera_rotate"):
		rotation_pressed = true
	elif event.is_action_released("camera_rotate"):
		rotation_pressed = false
	
	if event is InputEventMouseMotion and rotation_pressed:
		camera_rotation = event.get_relative()
	
	# ---- /Camera rotation ----