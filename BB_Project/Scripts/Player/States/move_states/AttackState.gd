extends 'res://Scripts/State.gd'

func get_name():
	return "Attack"
	
func enter():
	entity.get_child(7).attack()
	if(entity.anim_player.flip_h):
		entity.anim_player.position.x -= 10
	else:
		entity.anim_player.position.x += 10 
		
func _on_Player_Anim_animation_finished():
	if(entity.get_child(0).animation == 'Attack'):
		entity.set_state(entity.idleState)
	
