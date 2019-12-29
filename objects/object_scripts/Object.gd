extends Spatial

signal object_selected
signal object_deselected

onready var _selection_area = $Selection/SelectionArea
onready var _seleciton_indicator = $Selection/SelectionIndicator

var _selected := false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Object gets selected.
func start_select():
	_selected = true
	self.add_to_group("selected_nodes")
	emit_signal("object_selected")

# Object is no longer selected.
func stop_select():
	_selected = false
	self.remove_from_group("selected_nodes")
	emit_signal("object_deselected")

func die():
	self.stop_select()
	self.queue_free()

# Object is given order to self destruct.
func delete():
	self.die()

func _on_SelectionArea_input_event(camera, event, click_position, click_normal, shape_idx):
	if event.is_action_pressed("object_select"):
		# Call the selection function deferred. We have to selec ourselves after everything is deselected.
		# And the deselecting of everything happens deferred as well.
		self.call_deferred("start_select")