extends '../../State.gd'

func get_name():
	return 'Swap'
	
func enter():
	entity.party.swap(entity.party.currentIndex, true)
	entity.emit_signal('swapped')
	
func _on_Zulie_Anim_Player_animation_finished():
	if(entity.anim_player.animation == 'Swap'):
		entity.anim_player.visible = false 
		entity.anim_player = entity.anim_players.get_child(entity.partyIndex)
		entity.anim_player.visible = true
		entity.set_state(entity.previousState)

func _on_Dummy_Anim_Player_animation_finished():
	if(entity.anim_player.animation == 'Swap'):
		entity.anim_player.visible = false 
		entity.anim_player = entity.anim_players.get_child(entity.partyIndex)
		entity.anim_player.visible = true
		entity.set_state(entity.previousState)
