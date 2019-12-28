extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func appear():
	self.visible = true

func disappear():
	self.visible = false

func _on_Object_object_selected():
	self.appear()

func _on_Object_object_deselected():
	self.disappear()