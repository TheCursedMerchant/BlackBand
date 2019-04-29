#Base state that listens for events to change states 
extends "res://Scripts/State.gd"

func get_name():
	return "Idle"

func enter():
	print(get_name())

func update(delta):
	#Follow position 
	if(target.followTarget != null):
		target.position = target.followTarget.global_position
	
func handle_input(event):
	if(Input.is_action_just_pressed('special_01')):
		manager.set_state(manager.states[manager.findState("Aim")])
