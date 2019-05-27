extends "res://Scripts/State.gd"

var knife
var collide = null 

func get_name():
	return "Hang"

func enter():
	print("Player entered state: " + get_name())
	knife = target.knife
	
func handle_input(event):
	if(Input.is_action_just_pressed("special_01")):
		manager.set_state(manager.states[manager.findState("Idle")])
	elif(Input.is_action_just_pressed('ui_jump')):
		manager.set_state(manager.states[manager.findState("Jump")])
		
func update(delta):
	if(collide == null && target.grabTarget != null):
		collide = target.move_and_collide(target.grabTarget * 2)
		
	if(knife != null && knife.facingDir == dir.up):
		target.anim_player.frame = 1
		
		
		
func exit():
	if(knife != null):
		knife.stateManager.set_state(knife.stateManager.states[knife.stateManager.findState("Return")])
	collide = null 
	target.anim_player.frame = 0
