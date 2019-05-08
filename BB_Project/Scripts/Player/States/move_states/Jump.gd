extends "../../../State.gd"


var move = false

#Return state name
func get_name():
	return "Jump"

func handle_input(event):
	#Character swapping 
	if(Input.is_action_just_pressed('ui_right_select') && target.canSwap):
		manager.set_state(manager.states[manager.findState("Swap")])
		
	if(Input.is_action_pressed('ui_right')):
		move = true
		target.anim_player.flip_h = false
		target.facingDir = dir.right
	elif(Input.is_action_pressed('ui_left')):
		move = true
		target.anim_player.flip_h  = true
		target.facingDir = dir.left

func update(delta):
	target.motion.y = max(target.motion.y - target.jumpSpeed, -target.jumpHeight)
		
	if(Input.is_action_pressed('ui_right')):
		move = true
		target.anim_player.flip_h = false
		target.facingDir = dir.right
		target.motion.x = min(target.motion.x + target.acceleration, target.maxSpeed) 
	elif(Input.is_action_pressed('ui_left')):
		move = true
		target.anim_player.flip_h  = true
		target.facingDir = dir.left
		target.motion.x = max(target.motion.x - target.acceleration, -target.maxSpeed) 
			
	if(Input.is_action_just_released('ui_up') || target.motion.y <= -target.jumpHeight):
		manager.set_state(manager.states[manager.findState("Fall")])	
		
	if(Input.is_action_pressed('ui_attack') && target.canAttack):
		#Charge
		if(target.attackType == 'ranged'):
			if(target.shooter.currentCharge < target.shooter.chargeMax): 
				target.shooter.currentCharge += target.shooter.chargeRate
		else:
			manager.set_state(manager.states[manager.findState("Attack")])
			
	if(target.is_on_wall()):
		target.motion.x = lerp(target.motion.x, 0, target.friction)
		
	#Move 	
	target.motion = target.move_and_slide(target.motion, dir.up)
		
func jump_cut(motion, maxJumpHeight):
	if motion.y < -100:
		motion.y = 100
		

