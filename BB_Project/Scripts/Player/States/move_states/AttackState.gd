extends 'res://Scripts/State.gd'

func get_name():
	return "Attack"
	
func enter():
	print('Current Party Index: ' + str(entity.partyIndex))
	print('Current State: ' + entity.currentState.get_name())
	
	entity.motion.y = 0
	#Set attack on cooldown
	entity.canAttack = false
	
	#Change attack based on type 
	if(entity.attackType == 'melee'):
		entity.get_node('melee-point').attack()
	elif(entity.attackType == 'ranged'):
		entity.get_node('shoot-point').shoot()
		
func update(delta): 
	entity.motion.x = lerp(entity.motion.x, 0, entity.friction)
	entity.move_and_slide(entity.motion, dir.up)
	
func exit():
	entity.motion = Vector2()
		
func _on_Zulie_Anim_Player_animation_finished():
	if(entity.anim_player.animation == 'Attack'):
		if Input.is_action_pressed('ui_right'):
			entity.anim_player.flip_h = false
			entity.facingDir = dir.right
			entity.set_state(entity.moveState)
		elif Input.is_action_pressed('ui_left'):
			entity.anim_player.flip_h = true
			entity.facingDir = dir.left
			entity.set_state(entity.moveState)
		else:
			entity.set_state(entity.idleState)


func _on_Dummy_Anim_Player_animation_finished():
	if(entity.anim_player.animation == 'Attack'):
		if Input.is_action_pressed('ui_right'):
			entity.anim_player.flip_h = false
			entity.facingDir = dir.right
			entity.set_state(entity.moveState)
		elif Input.is_action_pressed('ui_left'):
			entity.anim_player.flip_h = true
			entity.facingDir = dir.left
			entity.set_state(entity.moveState)
		else:
			entity.set_state(entity.idleState)
