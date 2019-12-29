extends Node

signal new_program_created(program)

# Node that has all the programs as children.
var _programs: Node = null

onready var PROGRAM_TEMPLATE := preload("res://program/Program.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_programs = Node.new()
	add_child(_programs)


func create_new_program():
	var program = PROGRAM_TEMPLATE.instance()
	_programs.add_child(program)
	
	program.clear()
	emit_signal("new_program_created", program)
