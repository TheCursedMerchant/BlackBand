extends 'res://Scripts/State.gd'

func get_name():
	return "Attack"
	
func enter():
	entity.get_child(7).attack()
		
func _on_Player_Anim_animation_finished():
	if(entity.get_child(0).animation == 'Attack'):
		entity.set_state(entity.idleState)
