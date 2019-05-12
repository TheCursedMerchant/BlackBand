extends "res://Scripts/State.gd"

func get_name():
	return "Stop"
	
func enter():
	target.animPlayer.play("Spin")
	
func unhandled_input(event):
	if(Input.is_action_just_pressed("special_01")):
		target.animPlayer.play("Idle")
		target.animPlayer.flip_h = false
		target.animPlayer.flip_v = false
		manager.set_state(manager.states[manager.findState("Return")])
