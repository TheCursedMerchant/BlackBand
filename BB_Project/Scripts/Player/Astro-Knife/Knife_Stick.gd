extends "res://Scripts/State.gd"

var grabScene = preload("res://Scenes/Interactables/Grab-Point.tscn")

func get_name():
	return "Stick"
	
func enter():
	spawnGrabPoint(target.global_position)
	
func update(delta):
	if(target.stickParent.get("motion") != null):
		target.global_position = target.stickParent.global_position
	
func exit():
	if(target.grabPoint != null && target.weakGrabRef.get_ref()):
		target.grabPoint.queue_free()
	target.animPlayer.visible = true
	#target.stickRay.position = Vector2(0,0)
	
	
func spawnGrabPoint(loc):
	target.grabPoint = grabScene.instance(0)
	add_child(target.grabPoint)
	target.weakGrabRef = weakref(target.grabPoint)
	target.grabPoint.global_position = loc
	target.grabPoint.connect("body_entered", self, "_on_body_entered")
	
func _on_body_entered(body):
	if(body.get("type") == "PLAYER" && body.stateManager.currentState.get_name() == "Dash"):
		target.animPlayer.visible = false
		if(target.facingDir.x > 0):
			body.anim_player.flip_h = true
		else:
			body.anim_player.flip_h = false
		body.stateManager.set_state(body.stateManager.states[body.stateManager.findState("Hang")])

#func _on_GrabPoint_body_entered(body):
#	print("Collision!")
#	if(body.get("type") == "PLAYER" && body.stateManager.currentState.get_name() == "Dash"):
#		print("Player Collision with Grab point!")
#		body.stateManager.set_state(body.stateManager.states[body.stateManager.findState("Hang")])
