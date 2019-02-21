extends "../engine/entity.gd"

onready var anim_player = $Anim_Player

#States
var previousState 
var currentState
var idleState
var damageState 
var fallState

#State variables
var grounded = true

#Initialize Slime Enemy 
func _ready():
	currentHealth = health
	type = 'ENEMY'
	initializeEnemy()
	
	#Enter idle state
	if(currentState == null):
		set_state(idleState)
	else:
		set_state(currentState)
	
#Defer physics process to our state
func _physics_process(delta):
	is_grounded()
	currentState.update(delta)
	anim_player.play(currentState.get_name())

#Handle exiting and entering new state
func set_state(newState):
	if(currentState != null && currentState.has_method('exit')):
		currentState.exit()
	previousState = currentState
	currentState = newState
	currentState.enter()
	#print(currentState.get_name())
	#print(motion)
	
func initializeEnemy():
	#Static States
	idleState = $States/Idle
	damageState = $States/Damage
	fallState = $States/Fall
	
#Check if enemy is on the ground 
func is_grounded():
	if($ground_ray.is_colliding()):
		grounded = true
	else:
		grounded = false
		