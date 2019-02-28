extends 'res://Scripts/State.gd'

var timer = null 
var roamTime = .5

func get_name():
	return 'Roam'
	
func enter():
	#Pick a random facing direction 
	var decision = randi()%10 + 1
	if(decision > 5):
		entity.anim_player.flip_h = false
		entity.facingDir = dir.right
	else:
		entity.anim_player.flip_h = true
		entity.facingDir = dir.left
	
	#Timer Logic
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(roamTime)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	
func update(delta):
	#Move 	
	entity.motion = entity.move(entity.motion, entity.acceleration, entity.maxSpeed, entity.facingDir)
	
	#Check if entity is on the ground
	if(!entity.grounded):
		entity.set_state(entity.fallState)
		
func on_timeout_complete():
	 entity.set_state(entity.waitState)
	
func exit():
	timer.stop()


