extends "res://Scripts/State.gd"

var grabScene = preload("res://Scenes/Interactables/Grab-Point.tscn")


func get_name():
	return "Stick"
	
func enter():
	print("Knife current Position: " + str(target.global_position))
	spawnGrabPoint(target.global_position)
	
func spawnGrabPoint(loc):
	target.grabPoint = grabScene.instance(0)
	get_tree().get_root().add_child(target.grabPoint)
	target.grabPoint.global_position = loc
	#target.grabPoint.connect("body_entered", self, "on_body_entered")
	print("Grab point spawned at location: " + str(target.grabPoint.global_position))
	
func on_body_entered(body):
	print("Signal Fired!")
	if(body.get("type") == "PLAYER"):
		body.stateManager.set_state(body.stateManager.states[body.stateManager.findState("Hang")])
		
func exit():
	if(target.grabPoint != null):
		target.grabPoint.queue_free()


