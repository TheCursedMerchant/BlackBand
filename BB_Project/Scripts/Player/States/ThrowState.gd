extends "res://Scripts/State.gd"

func get_name():
	return "Throw"
		
func update(delta):
	#Slide with friction 
	target.motion.x = lerp(target.motion.x, 0, target.friction)

	#Check if entity is falling 
	if(!target.grounded):
		target.motion.y += target.gravity
		
	target.move_and_slide(target.motion, dir.up)

func _on_Astro_Anim_Player_animation_finished():
	if(manager.currentState.get_name() == "Throw"):
		manager.set_state(manager.previousState)
