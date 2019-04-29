extends "res://Scripts/State.gd"

func get_name():
	return "Chase"
	
func update(delta):
	var directionToTarget = null 
	
	#Chase the player
	if(target.chaseTarget != null):
		directionToTarget = (target.chaseTarget.position.x - target.position.x)
		#Face the target
		if(directionToTarget < 0):
			target.facingDir = dir.left
			target.anim_player.flip_h = true
			target.floor_checker.position.x = -target.maxSpeed/2
		else:
			target.facingDir = dir.right
			target.anim_player.flip_h = false
			target.floor_checker.position.x = target.maxSpeed/2
		#Check if in attack range 
		if(abs(directionToTarget) <= target.attackRange):
			manager.set_state(manager.states[manager.findState("Wait")])
		
	#Move 	
	if(target.check_ground()):
		target.motion = target.move(target.motion, target.acceleration, target.maxSpeed, target.facingDir)
	
	#Check if entity is on the ground
	if(!target.grounded):
		manager.set_state(manager.states[manager.findState("Fall")])
		
	
