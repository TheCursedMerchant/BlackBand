extends 'res://Scripts/State.gd'

func get_name():
	return "Attack"
	
func enter():
	entity.canAttack = false
	if(entity.attackType == 'melee'):
		entity.get_node('melee-point').attack()
	elif(entity.attackType == 'ranged'):
		entity.get_node('shoot-point').shoot()
	
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
	pass # Replace with function body.
