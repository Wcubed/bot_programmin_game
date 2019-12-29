extends Tree

var _root_item: TreeItem = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create the root TreeItem.
	_root_item = create_item()
	
	ProgramSystem.connect("new_program_created", self, "_on_new_program_created")

func _on_new_program_created(program: Program):
	var new_item := create_item(_root_item)
	new_item.set_text(0, program.name)
