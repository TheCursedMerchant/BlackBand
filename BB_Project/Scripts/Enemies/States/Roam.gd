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
		entity.floor_checker.position.x = entity.maxSpeed/2
	else:
		entity.anim_player.flip_h = true
		entity.facingDir = dir.left
		entity.floor_checker.position.x = -entity.maxSpeed/2
	
	#Timer Logic
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(roamTime)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	
func update(delta):
	#Move 	
	if(entity.check_ground()):
		entity.motion = entity.move(entity.motion, entity.acceleration, entity.maxSpeed, entity.facingDir)
	
	#Check if entity is on the ground
	if(!entity.grounded):
		entity.set_state(entity.fallState)
		
func on_timeout_complete():
	 entity.set_state(entity.waitState)
	
func exit():
	timer.stop()

func _on_DetectionBox_body_entered(body):
	if(body.get("type") == "PLAYER"):
		entity.target = body
		entity.set_state(entity.chaseState)
