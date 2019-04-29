extends "res://Scripts/State.gd"

onready var manager = get_parent()
onready var target = get_parent().get_parent()

func get_name():
	return "Aim"
	
func enter():
	print(get_name())
	
	#Move to the center of the player
	target.position = target.followTarget.get_parent().position

func handle_input(event):
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var inputDirection = Vector2(horizontal, vertical)
	
	#On release throw the knife 
	if(Input.is_action_just_released("special_01")):
		manager.set_state(manager.states[manager.findState("Throw")])
		
	#Adjust the knife direction according to directional input
	if(Input.is_action_pressed('ui_right')):
		if(vertical == 0):
			target.facingDir = dir.right
		elif(vertical < 0):
			target.facingDir = dir.u_right
		else:
			target.facingDir = dir.d_right
			
	if(Input.is_action_pressed('ui_left')):
		if(vertical == 0):
			target.facingDir = dir.left
		elif(vertical < 0):
			target.facingDir = dir.u_left
		else:
			target.facingDir = dir.d_left
			
	if(Input.is_action_pressed('ui_up')):
		if(horizontal == 0):
			target.facingDir = dir.up
		elif(horizontal < 0):
			target.facingDir = dir.u_left
		else:
			target.facingDir = dir.u_right
			 
	if (Input.is_action_pressed('ui_down')):
		if(horizontal == 0):
			target.facingDir = dir.down
		elif(horizontal < 0):
			target.facingDir = dir.d_left
		else:
			target.facingDir = dir.d_right
	
	
		
		
	
	

