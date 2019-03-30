extends '../../../State.gd'
		
#Return state name
func get_name():
	return "Idle"
	
#Check if entity is falling 
func update(delta):
	entity.motion.x = lerp(entity.motion.x, 0, entity.friction)
	entity.move_and_slide(entity.motion, dir.up)
	if(!entity.grounded):
		entity.set_state(entity.fallState)
	
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
	elif(Input.is_action_pressed('ui_up')):
		entity.set_state(entity.jumpState)
	
	if(Input.is_action_just_pressed('ui_down')):
		entity.set_state(entity.swapState)
		
	if(Input.is_action_just_pressed('ui_attack') && entity.canAttack):
		entity.set_state(entity.attackState)
		
		