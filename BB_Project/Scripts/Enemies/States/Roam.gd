extends 'res://Scripts/State.gd'

var timer = null 
var roamTime = .5

func get_name():
	return 'Roam'
	
func enter():
	#Pick a random facing direction 
	if(target.anim_player != null):
		var decision = randi()%10 + 1
		if(decision > 5):
			target.anim_player.flip_h = false
			target.facingDir = dir.right
			target.floor_checker.position.x = target.maxSpeed/2
		else:
			target.anim_player.flip_h = true
			target.facingDir = dir.left
			target.floor_checker.position.x = -target.maxSpeed/2
	
	#Timer Logic
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(roamTime)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	
func update(delta):
	#Move 	
	if(target.check_ground()):
		target.motion = target.move(target.motion, target.acceleration, target.maxSpeed, target.facingDir)
	
	#Check if entity is on the ground
	if(!target.grounded):
		manager.set_state(manager.states[manager.findState("Fall")])
		
func on_timeout_complete():
	 manager.set_state(manager.states[manager.findState("Wait")])
	
func exit():
	if(timer != null):
		timer.stop()

func _on_DetectionBox_body_entered(body):
	if(body.get("type") == "PLAYER"):
		target.chaseTarget = body
		manager.set_state(manager.states[manager.findState("Chase")])
