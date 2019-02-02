extends "../engine/entity.gd"

#Player States 
var idleState
var moveState
var jumpState
var fallState 

#Store our current State
var currentState

#Flag if checks for if out player is grounded 
onready var grounded = is_grounded()
onready var anim_player = $Player_Anim

#Initialize our state
func _ready():
	#Static States
	idleState = $States/Idle
	moveState = $States/Move
	jumpState = $States/Jump
	fallState = $States/Fall
	
	#Start player off in Idle state
	set_state(idleState)

#Defer physics process to our state
func _physics_process(delta):
	is_grounded()
	currentState.update(delta)
	anim_player.play(currentState.get_name())

#Defer input to our state
func _input(event):
	currentState.handle_input(event)

#Handle exiting and entering new state
func set_state(newState):
	if(currentState != null && currentState.has_method('exit')):
		currentState.exit()
	currentState = newState
	currentState.enter()
	#print(currentState.get_name())
	#print(motion)
	
#Check if player is on the ground 
func is_grounded():
	if($front_ray.is_colliding() || $back_ray.is_colliding()):
		grounded = true
	else:
		grounded = false
		
	
	



