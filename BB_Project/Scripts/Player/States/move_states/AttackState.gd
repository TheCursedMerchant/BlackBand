extends 'res://Scripts/State.gd'

var comboWindow = 2; 

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
	#Apply gravity 
	target.motion.y += target.gravity
	target.motion.x = lerp(target.motion.x, 0, target.friction)
	target.move_and_slide(target.motion, dir.up)
	
	#Check for combo 
	if(Input.is_action_just_pressed("ui_attack") 
		&& target.attackType == "melee"
		&& target.comboCount < 3
		&& target.anim_player.frame > (target.anim_player.frames.frames.size() - comboWindow) 
		&& target.grounded):
			target.comboCount += 1
			manager.set_state(manager.states[manager.findState("Attack")])
			target.get_node('melee-point').attack()
#func exit():
#	target.motion = Vector2()
		
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
	if(target.isAttackAnimation(target.anim_player.animation)):
		target.comboCount = 1
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
