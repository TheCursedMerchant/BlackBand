extends "res://Scripts/State.gd"

func get_name():
	return "Attack"
	
func enter(): 
	#print('State Entered!')
	target.get_node('../Hitbox').disabled = false 
	
func update(delta):
	if(!get_node("../../Sword-Anim").is_playing()):
		target.set_state(target.idleState)

func exit():
	target.active = false 