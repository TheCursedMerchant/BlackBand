extends "res://Scripts/State.gd"

func get_name():
	return "Chase"
	
func update(delta):
	var directionToTarget = null 
	
	#Chase the player
	if(entity.target != null):
		directionToTarget = (entity.target.position.x - entity.position.x)
		print(directionToTarget)
		#Face the target
		if(directionToTarget < 0):
			entity.facingDir = dir.left
			entity.anim_player.flip_h = true
		else:
			entity.facingDir = dir.right
			entity.anim_player.flip_h = false
		#Check if in attack range 
		if(abs(directionToTarget) <= entity.attackRange):
			entity.set_state(entity.waitState)
		
	#Move 	
	if(entity.check_ground()):
		entity.motion = entity.move(entity.motion, entity.acceleration, entity.maxSpeed, entity.facingDir)
	
	#Check if entity is on the ground
	if(!entity.grounded):
		entity.set_state(entity.fallState)
		
	
