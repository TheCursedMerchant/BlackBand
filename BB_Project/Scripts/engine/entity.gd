#Abstract class for all "living" beings 
extends KinematicBody2D

#Properties all objects that live will have 
export var health = 1
export var gravity = 10 
export var acceleration = 20
export var maxSpeed = 200
export var jumpHeight = 250
 
#State Variables 
var motion = Vector2()
var facingDir = dir.right

#All entities can move 
func move(motion, acceleration, maxSpeed, moveDir):
	
	#Move in the correct direction 
	if(moveDir == dir.right):
		motion.x = min(motion.x + acceleration, maxSpeed)
	elif(moveDir == dir.left):
		motion.x = max(motion.x - acceleration, -maxSpeed)
	
	#Apply and store that motion
	return move_and_slide(motion, dir.up)
	


