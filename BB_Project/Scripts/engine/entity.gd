extends KinematicBody2D

#Exposed Properties 
export var maxHealth = 10
export var maxSpeed = 150
export var jumpHeight = -200
export var gravityMultiplier = 2.5 
export var gravity = 10
export var acceleration = 50

var type = "ENTITY"

#Hidden Properties 
var currentHealth = maxHealth
var motion = Vector2()

#Default loop to check for death 
func _physics_process(delta):
	checkDeath()

#Change the entities' motion
func move(var motion, var acceleration, var speed, var direction):
	if direction == dir.right:
		motion.x = min(motion.x + acceleration, speed)
	elif direction == dir.left:
		motion.x = max(motion.x - acceleration, -speed)
	return motion

#Check if entity has no more health and kill it if it does 
func checkDeath():
	if(currentHealth <= 0):
		queue_free()
