extends '../../State.gd'

func get_name():
	return 'Swap'
	
func enter():
	#('Current State: ' + manager.currentState.get_name())
	target.canSwap = false 
	target.canAttack = false 
	target.party.swap(target.party.currentIndex, true)
	target.emit_signal('swapped')
	
	if(target.knife != null && target.knife.grabPoint != null && 
	target.knife.weakGrabRef != null && target.knife.weakGrabRef.get_ref()):
		target.knife.grabPoint.queue_free()
		
	
func _on_Zulie_Anim_Player_animation_finished():
	completeSwap()

func _on_Dummy_Anim_Player_animation_finished():
	completeSwap()
		
func completeSwap():
	if(target.anim_player.animation == 'Swap'):
		#Animation control
		var previousFlip = target.anim_player.flip_h
		target.anim_player.visible = false 
		target.anim_player = target.anim_players.get_child(target.partyIndex)
		target.anim_player.frame = 0
		target.anim_player.flip_h = previousFlip
		target.anim_player.visible = true
		
		#Check for conditions for entering next state 
		#If I still have some charge then shoot upon swapping else return to a move state
		if(target.shooter.currentCharge > 0 && target.attackType == 'ranged'):
			manager.set_state(manager.states[manager.findState("Attack")])
		elif(manager.previousState == manager.states[manager.findState("Move")] && (Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left"))):
			manager.set_state(manager.states[manager.findState("Move")])
		else:
			manager.set_state(manager.states[manager.findState("Idle")])
		
func exit():
	target.canSwap = true
	target.canAttack = true
	
