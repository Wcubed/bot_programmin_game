extends Spatial

export(float, 0, 10) var camera_speed := 2.0

onready var yaw_object = $Yaw
onready var pitch_object = $Yaw/Pitch

var forward_pressed := false
var back_pressed := false
var left_pressed := false
var right_pressed := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera_movement := Vector3()
	
	if forward_pressed:
		camera_movement.z -= camera_speed
	if back_pressed:
		camera_movement.z += camera_speed
	if left_pressed:
		camera_movement.x -= camera_speed
	if right_pressed:
		camera_movement.x += camera_speed
	
	self.translate(camera_movement * delta)

func _input(event):
	if event.is_action_pressed("camera_forward"):
		forward_pressed = true
	elif event.is_action_released("camera_forward"):
		forward_pressed = false
		
	if event.is_action_pressed("camera_back"):
		back_pressed = true
	elif event.is_action_released("camera_back"):
		back_pressed = false
	
	if event.is_action_pressed("camera_left"):
		left_pressed = true
	elif event.is_action_released("camera_left"):
		left_pressed = false
	
	if event.is_action_pressed("camera_right"):
		right_pressed = true
	elif event.is_action_released("camera_right"):
		right_pressed = false