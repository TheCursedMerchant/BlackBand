extends '../State.gd'

#Return state name
func get_name():
	return "Move"

#Move the player 
func update(delta):	
	#Move 	
	entity.motion = entity.move(entity.motion, entity.acceleration, entity.maxSpeed, entity.facingDir)
	
	#Check if on floor 
	if(!entity.grounded):
		entity.set_state(entity.fallState)
	
func handle_input(event):
	#Move based on direction 
	if(Input.is_action_pressed("ui_right")):
		entity.anim_player.flip_h  = false
		entity.facingDir = dir.right
	elif(Input.is_action_pressed("ui_left")):
		entity.anim_player.flip_h  = true
		entity.facingDir = dir.left
	else:
		entity.set_state(entity.idleState)
	
	#Jumping 
	if(Input.is_action_pressed('ui_up')):
		entity.set_state(entity.jumpState)
	
	if(Input.is_action_pressed('ui_down')):
		entity.get_child(6).swap(entity.partyIndex, true)
		
		

