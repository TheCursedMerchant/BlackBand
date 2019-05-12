extends "res://Scripts/State.gd"

func get_name():
	return "Return"
	
func update(delta):
	#Follow position 
	if(target.followTarget != null):
		target.position.x += (target.followTarget.global_position.x - target.global_position.x) * target.followPercent
		target.position.y += (target.followTarget.global_position.y - target.global_position.y) * target.followPercent
		#Check if we made it back to the targetPosition 
	if( (target.followTarget.global_position.x - target.global_position.x) == 0 &&
		(target.followTarget.global_position.y - target.global_position.y) == 0 ):
			manager.set_state(manager.states[manager.findState("Idle")])
	else:
		manager.set_state(manager.states[manager.findState("Idle")])
		
	
	