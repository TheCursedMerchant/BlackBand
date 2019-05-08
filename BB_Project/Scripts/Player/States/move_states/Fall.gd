extends '../../../State.gd'

#Return states name 
func get_name():
	return "Fall"
	
func handle_input(event):
	#Character Actions
	if(Input.is_action_just_pressed('ui_right_select')):
		manager.set_state(manager.states[manager.findState("Swap")])
	
func update(delta):
	
	#Apply gravity 
	target.motion.y += target.gravity
	 
	if(Input.is_action_pressed('ui_right')):
		target.anim_player.flip_h = false
		target.facingDir = dir.right		
		target.motion.x = min(target.motion.x + target.acceleration, target.maxSpeed) 
	elif(Input.is_action_pressed('ui_left')):
		target.anim_player.flip_h = true
		target.facingDir = dir.left	
		target.motion.x = max(target.motion.x - target.acceleration, -target.maxSpeed)
		
	if(target.is_on_wall()):
		target.motion.x = lerp(target.motion.x, 0, target.friction)
		
	#Apply motion change  
	target.move_and_slide(target.motion)
		
	if(Input.is_action_pressed('ui_attack') && target.canAttack):
		#Charge
		if(target.attackType == 'ranged'):
			if(target.shooter.currentCharge < target.shooter.chargeMax): 
				target.shooter.currentCharge += target.shooter.chargeRate
		else:
			manager.set_state(manager.states[manager.findState("Attack")])
			
	#Check if I hit the ground 
	if(target.grounded):
		if(Input.is_action_pressed('ui_right') || Input.is_action_pressed('ui_left')):
			manager.set_state(manager.states[manager.findState("Move")])
		else:
			manager.set_state(manager.states[manager.findState("Idle")])
			