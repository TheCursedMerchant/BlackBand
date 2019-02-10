extends '../../../State.gd'

#Return states name 
func get_name():
	return "Fall"
	
func update(delta):
	
	#Apply gravity 
	entity.motion.y += entity.gravity
	
	if(Input.is_action_pressed('ui_right')):
		entity.anim_player.flip_h = false
		entity.facingDir = dir.right		
		entity.motion.x = min(entity.motion.x + entity.acceleration, entity.maxSpeed) 
	elif(Input.is_action_pressed('ui_left')):
		entity.anim_player.flip_h = true
		entity.facingDir = dir.left	
		entity.motion.x = max(entity.motion.x - entity.acceleration, -entity.maxSpeed) 
	
	#Apply motion change  
	entity.motion = entity.move_and_slide(entity.motion, dir.up)
	
	#Character swapping 
	if(Input.is_action_just_pressed('ui_down')):
		entity.get_child(6).swap(entity.partyIndex, true)
	
	#Check if I hit the ground 
	if(entity.grounded):
		if(Input.is_action_pressed('ui_right') || Input.is_action_pressed('ui_left')):
			entity.set_state(entity.moveState)
		else:
			entity.set_state(entity.idleState)