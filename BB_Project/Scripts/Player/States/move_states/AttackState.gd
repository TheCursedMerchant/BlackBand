extends 'res://Scripts/State.gd'

func get_name():
	return "Attack"
	
func enter():	
	target.motion.y = 0
	#Set attack on cooldown
	target.canAttack = false
	
	if(target.currentCharacter == "Astro"):
		target.knife.animPlayer.visible = false 
	
	#Change attack based on type 
	if(target.attackType == 'melee'):
		target.get_node('melee-point').attack()
	elif(target.attackType == 'ranged'):
		target.get_node('shoot-point').shoot()
		
func update(delta): 
	target.motion.x = lerp(target.motion.x, 0, target.friction)
	target.move_and_slide(target.motion, dir.up)
	
func exit():
	target.motion = Vector2()
		
func _on_Zulie_Anim_Player_animation_finished():
	if(target.anim_player.animation == 'Attack'):
		if Input.is_action_pressed('ui_right'):
			target.anim_player.flip_h = false
			target.facingDir = dir.right
			manager.set_state(manager.states[manager.findState("Move")])
		elif Input.is_action_pressed('ui_left'):
			target.anim_player.flip_h = true
			target.facingDir = dir.left
			manager.set_state(manager.states[manager.findState("Move")])
		else:
			manager.set_state(manager.states[manager.findState("Idle")])


func _on_Dummy_Anim_Player_animation_finished():
	if(target.anim_player.animation == 'Attack'):
		target.knife.animPlayer.visible = true
		if Input.is_action_pressed('ui_right'):
			target.anim_player.flip_h = false
			target.facingDir = dir.right
			manager.set_state(manager.states[manager.findState("Move")])
		elif Input.is_action_pressed('ui_left'):
			target.anim_player.flip_h = true
			target.facingDir = dir.left
			manager.set_state(manager.states[manager.findState("Move")])
		else:
			manager.set_state(manager.states[manager.findState("Idle")])
