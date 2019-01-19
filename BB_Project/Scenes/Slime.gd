extends KinematicBody2D

#Constant Statistics 
const MAX_HEALTH = 10
const TYPE = "ENEMY" 

#Initialize health 
var currentHealth = MAX_HEALTH

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	if(currentHealth <= 0):
		queue_free()
