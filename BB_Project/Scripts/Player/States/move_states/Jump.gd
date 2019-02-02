extends "../State.gd"


#Return state name
func get_name():
	return "Jump"
	
	
func update(delta):
	
	entity.motion.y = -entity.jumpHeight
		
	if(Input.is_action_pressed('ui_right')):
		entity.anim_player.flip_h = false
		entity.facingDir = dir.right	
		entity.motion.x = min(entity.motion.x + entity.acceleration, entity.maxSpeed) 
	elif(Input.is_action_pressed('ui_left')):
		entity.anim_player.flip_h  = true
		entity.facingDir = dir.left	
		entity.motion.x = max(entity.motion.x - entity.acceleration, -entity.maxSpeed) 
		
	#Move 	
	entity.motion = entity.move_and_slide(entity.motion, dir.up)
	
	if(Input.is_action_just_released('ui_up') || entity.is_on_ceiling() || entity.motion.y == -entity.jumpHeight):
		entity.set_state(entity.fallState) 	
