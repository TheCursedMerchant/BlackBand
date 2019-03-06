extends "../engine/entity.gd"

#Party Properties 
var partyIndex
var initial = true
var canAttack = false 

#Damage Properties 
export var meleeDamage = 10 
export var h_meleeKnockback = 40
export var v_meleeKnockback = -20

#Player States 
var idleState
var moveState
var jumpState
var fallState 
var swapState
var damageState
var attackState 

#Store our current State
var previousState 
var currentState

#Flag if checks for if out player is grounded 
onready var grounded = is_grounded()
onready var anim_player = $Player_Anim

#Initialize our state
func _ready():
	#Set my camera 
	camera = get_node('../MainCamera')
	#Set entity type 
	type = 'PLAYER'
	#Set our position in the party 
	partyIndex = 0
	#Initialize our player 
	initializePlayer()
	#Enter idle state
	if(currentState == null):
		set_state(idleState)
	else:
		set_state(currentState)
	#Set the main camera 
	if(get_node("../MainCamera").player == null):
		get_node("../MainCamera").player = self
		
	#Set me as the healthbar's player 
	if(get_node("../MainCamera/HUD/Main_GUI").player == null):
		get_node("../MainCamera/HUD/Main_GUI").player = self
	
#Defer physics process to our state
func _physics_process(delta):
	is_grounded()
	currentState.update(delta)
	anim_player.play(currentState.get_name())

#Defer input to our state
func _input(event):
	currentState.handle_input(event)
	$"shoot-point".handle_input(event) 

#Handle exiting and entering new state
func set_state(newState):
	if(currentState != null && currentState.has_method('exit')):
		currentState.exit()
	previousState = currentState 
	currentState = newState
	currentState.enter()
	#print(motion)
	
#Check if player is on the ground 
func is_grounded():
	if($front_ray.is_colliding() || $back_ray.is_colliding()):
		grounded = true
	else:
		grounded = false
		
func initializePlayer():
	#Static States
	idleState = $States/Idle
	moveState = $States/Move
	jumpState = $States/Jump
	fallState = $States/Fall
	damageState = $States/Damage
	attackState = $States/Attack 
	
