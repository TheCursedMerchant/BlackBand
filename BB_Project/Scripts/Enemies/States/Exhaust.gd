extends "res://Scripts/State.gd"

var timer = Timer.new()

func get_name():
	return "Exhaust"

func _ready():
	timer.set_one_shot(true)
	timer.set_wait_time(target.exhaustTime)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
func enter():
	target.takeDamage(target.currentDamage)
	timer.start()
	
func update(delta):
	
	#Slide with friction 
	target.motion.x = lerp(target.motion.x, 0, target.friction)

	#Check if entity is falling 
	if(!target.grounded):
		target.motion.y += target.gravity
		
	target.move_and_slide(target.motion, dir.up)
	
func exit():
	target.currentDamage = 0
	timer.stop()
	
func on_timeout_complete():
	manager.set_state(manager.states[manager.findState("Roam")])