extends Spatial

export(float, 0, 10) var camera_speed := 2.0

onready var yaw_object = $Yaw
onready var pitch_object = $Yaw/Pitch

var rotation_pressed := false

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

func _input(event):
	# ---- Camera rotation ----
	
	if event.is_action_pressed("camera_rotate"):
		rotation_pressed = true
	elif event.is_action_released("camera_rotate"):
		rotation_pressed = false
	
	# ---- /Camera rotation ----