extends '../../../State.gd'
		
		
#Return state name
func get_name():
	return "Idle"

#This stops storing motion before jumping 
func enter():
	entity.motion = Vector2()
	entity.anim_player.position.x = 0
	
#Check if entity is falling 
func update(delta):
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
		entity.get_child(6).swap(entity.partyIndex, true)
		
	if(Input.is_action_just_pressed('ui_melee') && entity.canAttack):
		entity.canAttack = false 
		entity.set_state(entity.attackState)
		
		