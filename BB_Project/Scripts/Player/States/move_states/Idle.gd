extends '../../../State.gd'
		
#Return state name
func get_name():
	return "Idle"

func update(delta):
	
	target.motion.x = lerp(target.motion.x, 0, target.friction)
	target.move_and_slide(target.motion, dir.up)
	
	#Check if entity is falling 
	if(!target.grounded):
		manager.set_state(manager.states[manager.findState("Fall")])
		
	if(Input.is_action_pressed('ui_attack') && target.canAttack):
		#Charge
		if(target.attackType == 'ranged'):
			#Animation control 
			if(!target.shooter.chargeStarted):
				target.shooter.chargeStarted = true
				target.shooter.currentAnimation = 'start'
			
			#Charge logic 
			if(target.shooter.currentCharge < target.shooter.chargeMax): 
				target.shooter.currentCharge += target.shooter.chargeRate
		else:
			manager.set_state(manager.states[manager.findState("Attack")])
	
#Idle's job is to wait for movement 
func handle_input(event):
	#Movement 
	if Input.is_action_pressed('ui_right'):
		target.anim_player.flip_h = false
		target.facingDir = dir.right
		manager.set_state(manager.states[manager.findState("Move")])
	elif Input.is_action_pressed('ui_left'):
		target.anim_player.flip_h = true
		target.facingDir = dir.left
		manager.set_state(manager.states[manager.findState("Move")])
	elif(Input.is_action_just_pressed('ui_jump')):
		manager.set_state(manager.states[manager.findState("Jump")])
	
	#Actions 
	if(Input.is_action_just_pressed('ui_right_select') && target.canSwap):
		manager.set_state(manager.states[manager.findState("Swap")])