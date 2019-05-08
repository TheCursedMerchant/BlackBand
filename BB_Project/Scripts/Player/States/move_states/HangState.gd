extends "res://Scripts/State.gd"

var knife 

func get_name():
	return "Hang"

func enter():
	print("Player entered state: " + get_name())
	knife = target.knife

func handle_input(event):
	if(Input.is_action_just_pressed("special_01")):
		manager.set_state(manager.states[manager.findState("Idle")])
		
func exit():
	if(knife != null):
		knife.stateManager.set_state(knife.stateManager.states[knife.stateManager.findState("Idle")])
