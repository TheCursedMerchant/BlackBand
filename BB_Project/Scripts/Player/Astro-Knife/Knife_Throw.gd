extends "res://Scripts/State.gd"

const ZERO_MOTION = Vector2(0, 0)
var motion = Vector2(0, 0)
var animPlayer = null 
var colShape

func get_name():
	return "Throw"
	
func enter():
	animPlayer = target.animPlayer
	colShape = target.colShape
#	print("Knife entered: " + get_name() + " state")
#	print("Throw Distance length: " + str(target.throwDistance.length()))
	target.animPlayer.play("Throw")
	match target.facingDir:
		dir.up:
			target.colShape.rotation_degrees = 0
			animPlayer.frame = 1
			animPlayer.flip_v = true
			animPlayer.flip_h = false
		dir.down:
			target.colShape.rotation_degrees = 0
			animPlayer.frame = 1
			animPlayer.flip_v = false
			animPlayer.flip_h = false
		dir.left:
			target.colShape.rotation_degrees = 90
			animPlayer.frame = 0
			animPlayer.flip_v = false
			animPlayer.flip_h = true
		dir.right:
			target.colShape.rotation_degrees = 90
			animPlayer.frame = 0
			animPlayer.flip_v = false
			animPlayer.flip_h = false
		dir.u_left:
			target.colShape.rotation_degrees = -45
			animPlayer.frame = 2
			animPlayer.flip_v = true
			animPlayer.flip_h = false
		dir.d_left:
			target.colShape.rotation_degrees = 45
			animPlayer.frame = 2
			animPlayer.flip_v = false
			animPlayer.flip_h = false
		dir.u_right:
			target.colShape.rotation_degrees = 45
			animPlayer.frame = 2
			animPlayer.flip_v = true
			animPlayer.flip_h = true
		dir.d_right:
			target.colShape.rotation_degrees = -45
			animPlayer.frame = 2
			animPlayer.flip_h = true
			animPlayer.flip_v = false 
			
func update(delta):
	motion += target.facingDir * target.throwSpeed
#	print("Knife entered: " + get_name() + " state")
#	print("Current Motion length: " + str(motion.length()))
	if(motion.length() >= target.throwDistance.length()):
		manager.set_state(manager.states[manager.findState("Stop")])
	else:
		target.position += motion * delta
		
	if(target.stickRay.is_colliding()):
		if(target.stickRay.get_collider().get("type") != "PLAYER"):
			manager.set_state(manager.states[manager.findState("Stick")])
			
		
func exit():
	motion = ZERO_MOTION
	
