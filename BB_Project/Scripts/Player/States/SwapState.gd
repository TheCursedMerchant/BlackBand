extends '../../State.gd'

func get_name():
	return 'Swap'
	
func enter():
	entity.party.swap(entity.party.currentIndex, true)
	entity.emit_signal('swapped')
	
func _on_Zulie_Anim_Player_animation_finished():
	completeSwap()

func _on_Dummy_Anim_Player_animation_finished():
	completeSwap()
		
func completeSwap():
	if(entity.anim_player.animation == 'Swap'):
		var previousFlip = entity.anim_player.flip_h
		entity.anim_player.visible = false 
		entity.anim_player = entity.anim_players.get_child(entity.partyIndex)
		entity.anim_player.flip_h = previousFlip
		entity.anim_player.visible = true
		if(entity.previousState == entity.moveState && (Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left"))):
			entity.set_state(entity.moveState)
		else:
			entity.set_state(entity.idleState)
		
