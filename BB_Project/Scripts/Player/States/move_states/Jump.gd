extends "../../../State.gd"

#Return state name
func get_name():
	return "Jump"
		
func update(delta):
	entity.motion.y = max(entity.motion.y - entity.jumpSpeed, -entity.jumpHeight)
		
	if(Input.is_action_pressed('ui_right')):
		entity.anim_player.flip_h = false
		entity.facingDir = dir.right	
		entity.motion.x = min(entity.motion.x + entity.acceleration, entity.maxSpeed) 
	elif(Input.is_action_pressed('ui_left')):
		entity.anim_player.flip_h  = true
		entity.facingDir = dir.left	
		entity.motion.x = max(entity.motion.x - entity.acceleration, -entity.maxSpeed) 
		
	#Character swapping 
	if(Input.is_action_just_pressed('ui_right_select')):
		entity.set_state(entity.swapState)
		
	if(Input.is_action_just_released('ui_up') || entity.motion.y <= -entity.jumpHeight):
		entity.set_state(entity.fallState) 	
		
	if(Input.is_action_pressed('ui_attack') && entity.canAttack):
		#Charge
		if(entity.attackType == 'ranged'):
			if(entity.shooter.currentCharge < entity.shooter.chargeMax): 
				entity.shooter.currentCharge += entity.shooter.chargeRate
				print(entity.shooter.currentCharge)
		else:
			entity.set_state(entity.attackState)
			
	if(Input.is_action_just_released('ui_attack') && entity.canAttack && entity.attackType == 'ranged'):
		entity.set_state(entity.attackState)
	
	if(entity.is_on_wall()):
		entity.motion.x = lerp(entity.motion.x, 0, entity.friction)
		
	#Move 	
	entity.motion = entity.move_and_slide(entity.motion, dir.up)
		
func jump_cut(motion, maxJumpHeight):
	if motion.y < -100:
		motion.y = 100
