extends "../engine/entity.gd"

#States
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
	set_state(idleState)
	
#Defer physics process to our state
func _physics_process(delta):
	is_grounded()
	currentState.update(delta)

#Handle exiting and entering new state
func set_state(newState):
	if(currentState != null && currentState.has_method('exit')):
		currentState.exit()
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