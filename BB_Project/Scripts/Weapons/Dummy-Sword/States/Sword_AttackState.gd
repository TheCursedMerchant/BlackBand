extends "res://Scripts/State.gd"

func get_name():
	return "Attack"
	
func enter(): 
	print('State Entered!')
	entity.get_node('../Hitbox').disabled = false 
	
func update(delta):
	if(!get_node("../../Sword-Anim").is_playing()):
		entity.set_state(entity.idleState)

func exit():
	entity.active = false 