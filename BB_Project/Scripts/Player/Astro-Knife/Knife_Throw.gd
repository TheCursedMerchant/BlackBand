extends "res://Scripts/State.gd"

func get_name():
	return "Throw"
	
func enter():
	print(get_name())
	
func handle_input(event):
	if(Input.is_action_just_pressed('special_01')):
		manager.set_state(manager.states[manager.findState("Idle")])
