extends "res://Scripts/State.gd"

onready var manager = get_parent()
onready var target = get_parent().get_parent()

func get_name():
	return "Throw"
	
func enter():
	print(get_name())
	
func handle_input(event):
	if(Input.is_action_just_pressed('special_01')):
		manager.set_state(manager.states[manager.findState("Idle")])
