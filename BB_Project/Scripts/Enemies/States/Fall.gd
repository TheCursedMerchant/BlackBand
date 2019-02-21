extends 'res://Scripts/State.gd'

func get_name():
	return "Fall"
	
func update(delta):
	
	#Apply gravity 
	entity.motion.y += entity.gravity
	
	#Apply motion change  
	entity.motion = entity.move_and_slide(entity.motion, dir.up)
	
	if(entity.grounded):
		entity.set_state(entity.idleState)