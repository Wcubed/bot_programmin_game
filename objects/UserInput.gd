extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _deselect_all_objects():
	get_tree().call_group("selected_nodes", "stop_select")

func _unhandled_input(event):
	if event.is_action_pressed("selected_delete"):
		# Delete all selected units.
		get_tree().call_group("selected_nodes", "delete")
	elif event.is_action_pressed("selected_deselect_all"):
		self._deselect_all_objects()
	elif event.is_action_pressed("object_select"):
		# We deselect all the objects, then we can see if the ray-tracing hits one.
		self._deselect_all_objects()