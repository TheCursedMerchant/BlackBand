#Abstract class for all "living" beings 
extends KinematicBody2D

#Properties all objects that live will have 
export var health = 3
export var gravity = 10 
export var acceleration = 20
export var maxSpeed = 200
export var jumpHeight = 300
export var jumpSpeed = 10
export var friction = .1
export var jumpMoveModifier = 2
 
#State Variables 
var motion = Vector2(0, 0)
var facingDir = dir.right
var type = 'entity'
onready var currentHealth = health
onready var global = get_node("/root/global")
var camera = null
var mainGUI = null

#Damage Variables
var knockback = Vector2(0, 0) 
var knockbackDir = 1
var currentDamage = 0
var damageTime = .2
var floor_velocity = Vector2()

#All entities can move 
func move(motion, acceleration, maxSpeed, moveDir):
	#Move in the correct direction 
	if(moveDir == dir.right):
		motion.x = min(motion.x + acceleration, maxSpeed)
	elif(moveDir == dir.left):
		motion.x = max(motion.x - acceleration, -maxSpeed)
		
	#Apply floor velocity
	motion += floor_velocity
	
	#Apply and store that motion
	return move_and_slide(motion, dir.up)
	
#Debug function 
func takeDamage(dam):
	#Apply Damage and check for death 
	currentHealth -= dam 
	if(currentHealth <= 0):
		queue_free()
	print(currentHealth)
		
