#Base state that listens for events to change states 
extends "res://Scripts/State.gd"

func get_name():
	return "Idle"
	
func enter():
	target.colShape.rotation_degrees = 0
	target.animPlayer.play("Idle")
	target.animPlayer.flip_v = false
	target.animPlayer.flip_h = false

func update(delta):
	#Follow position 
	if(target.followTarget != null):
		target.position.x += (target.followTarget.global_position.x - target.global_position.x) * target.followPercent
		target.position.y += (target.followTarget.global_position.y - target.global_position.y) * target.followPercent
		
func handle_input(event):
	if(Input.is_action_just_pressed('special_01') && !target.user.stateManager.currentState.active):
		manager.set_state(manager.states[manager.findState("Aim")])
