extends 'res://Scripts/State.gd'

func get_name():
	return "Fall"
	
func update(delta):
	
	#Apply gravity 
	target.motion.y += target.gravity
	
	#Apply motion change  
	target.motion = target.move_and_slide(target.motion, dir.up)
	
	if(target.grounded):
		manager.set_state(manager.previousState)