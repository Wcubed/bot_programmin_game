extends Node
class_name Instruction

var _title := ""

# Each instruction has 1 input, and can have multiple outputs.
# The only exception to this is the start instruction, which has no inputs.

# All Instructions that have this one as their descendant.
var _predecessors := []
# All outputs, as: name(String)->Instruction relations.
var _outputs := Dictionary()

func _ready():
	_title = "Generic Instruction"

# Connects an output to a given instruction, if the output exists.
func connect_output(output_name: String, instruction: Instruction):
	if _outputs.has(output_name):
		_outputs[output_name] = instruction