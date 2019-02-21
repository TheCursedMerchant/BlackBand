#Abstract class for all "living" beings 
extends KinematicBody2D

#Properties all objects that live will have 
export var health = 3
export var gravity = 10 
export var acceleration = 20
export var maxSpeed = 200
export var jumpHeight = 250
 
#State Variables 
var motion = Vector2(0, 0)
var facingDir = dir.right
var type = 'entity'
onready var currentHealth = health

#Damage Variables
var knockback = Vector2(0, 0) 
var knockbackDir = 1
var currentDamage = 0
var damageTime = .2

#All entities can move 
func move(motion, acceleration, maxSpeed, moveDir):
	#Move in the correct direction 
	if(moveDir == dir.right):
		motion.x = min(motion.x + acceleration, maxSpeed)
	elif(moveDir == dir.left):
		motion.x = max(motion.x - acceleration, -maxSpeed)
	
	#Apply and store that motion
	return move_and_slide(motion, dir.up)
	
#Debug function 
func takeDamage(dam):
	#Apply Damage and check for death 
	currentHealth -= dam 
	if(currentHealth <= 0):
		queue_free()