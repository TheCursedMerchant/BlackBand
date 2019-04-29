extends '../../../State.gd'

#Return state name
func get_name():
	return "Move"

#Move the player 
func update(delta):	
	#Move 	
	target.motion = target.move(target.motion, target.acceleration, target.maxSpeed, target.facingDir)
	
	#Check if on floor 
	if(!target.grounded):
		manager.set_state(manager.states[manager.findState("Fall")])
		
	if(Input.is_action_pressed('ui_attack') && target.canAttack):
		#Charge
		if(target.attackType == 'ranged'):
			if(target.shooter.currentCharge < target.shooter.chargeMax): 
				target.shooter.currentCharge += target.shooter.chargeRate
		else:
			manager.set_state(manager.states[manager.findState("Attack")])
	
func handle_input(event):
	#Move based on direction 
	if(Input.is_action_pressed("ui_right")):
		target.anim_player.flip_h  = false
		target.facingDir = dir.right
	elif(Input.is_action_pressed("ui_left")):
		target.anim_player.flip_h  = true
		target.facingDir = dir.left
	else:
		manager.set_state(manager.states[manager.findState("Idle")])
	
	#Jumping 
	if(Input.is_action_just_pressed('ui_jump')):
		manager.set_state(manager.states[manager.findState("Jump")])
	
	if(Input.is_action_just_pressed('ui_right_select')):
		manager.set_state(manager.states[manager.findState("Swap")])
		
		
		
		

