extends '../../State.gd'

func get_name():
	return 'Swap'
	
func enter():
	print('Current State: ' + entity.currentState.get_name())
	entity.canSwap = false 
	entity.canAttack = false 
	entity.party.swap(entity.party.currentIndex, true)
	entity.emit_signal('swapped')
	
func _on_Zulie_Anim_Player_animation_finished():
	completeSwap()

func _on_Dummy_Anim_Player_animation_finished():
	completeSwap()
		
func completeSwap():
	if(entity.anim_player.animation == 'Swap'):
		#Animation control
		var previousFlip = entity.anim_player.flip_h
		entity.anim_player.visible = false 
		entity.anim_player = entity.anim_players.get_child(entity.partyIndex)
		entity.anim_player.frame = 0
		entity.anim_player.flip_h = previousFlip
		entity.anim_player.visible = true
		
		#Check for conditions for entering next state 
		
		#If I still have some charge then shoot upon swapping else return to a move state
		if(entity.shooter.currentCharge > 0 && entity.attackType == 'ranged'):
			entity.set_state(entity.attackState)
		elif(entity.previousState == entity.moveState && (Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left"))):
			entity.set_state(entity.moveState)
		else:
			entity.set_state(entity.idleState)
		
func exit():
	entity.canSwap = true
	entity.canAttack = true
	
