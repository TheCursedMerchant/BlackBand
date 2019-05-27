extends "res://Scripts/State.gd"

var startingLoc = Vector2()
var timer = Timer.new()
var knockbackTime = .2

func get_name():
	return "Knockback"
	
func _ready():
	timer.set_one_shot(true)
	timer.set_wait_time(knockbackTime)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
func enter():
	timer.start()
	
func update(delta):
	print(timer.time_left)
	target.motion = target.knockback
	target.move_and_slide(target.motion, dir.up)
	
func exit():
	timer.stop()
	
func on_timeout_complete():
	print("IM DONE!")
	manager.set_state(manager.states[manager.findState("Idle")])
	
