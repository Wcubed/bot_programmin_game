extends Node
class_name Program

onready var _instructions = $Instructions

var _start_instruction : Instruction = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func clear():
	# Clears out the program so it's a blank slate again.
	for child in _instructions.get_children():
		_instructions.remove_child(child)
		child.queue_free()

	# Add the start instruction.
	_start_instruction = StartInstruction.new()
	add_instruction(_start_instruction)

func add_instruction(instruction: Instruction) -> void:
	_instructions.add_child(instruction)