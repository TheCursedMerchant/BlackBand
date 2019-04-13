extends '../../../State.gd'
		
#Return state name
func get_name():
	return "Idle"
	
func update(delta):
	
	entity.motion.x = lerp(entity.motion.x, 0, entity.friction)
	entity.move_and_slide(entity.motion, dir.up)
	
	#Check if entity is falling 
	if(!entity.grounded):
		entity.set_state(entity.fallState)
		
	if(Input.is_action_pressed('ui_attack') && entity.canAttack):
		#Charge
		if(entity.attackType == 'ranged'):
			#Animation control 
			if(!entity.shooter.chargeStarted):
				entity.shooter.chargeStarted = true
				entity.shooter.currentAnimation = 'start'
			
			#Charge logic 
			if(entity.shooter.currentCharge < entity.shooter.chargeMax): 
				entity.shooter.currentCharge += entity.shooter.chargeRate
				print(entity.shooter.currentCharge)
		else:
			entity.set_state(entity.attackState)
	
#Idle's job is to wait for movement 
func handle_input(event):
	if Input.is_action_pressed('ui_right'):
		entity.anim_player.flip_h = false
		entity.facingDir = dir.right
		entity.set_state(entity.moveState)
	elif Input.is_action_pressed('ui_left'):
		entity.anim_player.flip_h = true
		entity.facingDir = dir.left
		entity.set_state(entity.moveState)
	elif(Input.is_action_just_pressed('ui_jump')):
		entity.set_state(entity.jumpState)
	
	if(Input.is_action_just_pressed('ui_right_select') && entity.canSwap):
		entity.set_state(entity.swapState)
			
	
		
	
		
	
		