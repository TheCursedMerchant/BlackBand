extends 'res://Scripts/State.gd'

var decideTime = 1 
var timer = null

func get_name():
	return 'Wait'
	
func enter():
	target.motion = Vector2()
	
	#Timer Logic
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(decideTime)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	
	
func update(delta):
	#Check if entity is on the ground 
	if(!target.grounded):
		manager.set_state(manager.states[manager.findState("Fall")])
		
func on_timeout_complete():
	manager.set_state(manager.states[manager.findState("Roam")])
	
func exit():
	timer.stop()
		
