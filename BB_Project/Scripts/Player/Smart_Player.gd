
#This root player object will dynamically load player objects as they are needed 
#It will also act as the root node that all physics processes effect 
extends 'res://Scripts/engine/entity.gd'

#Signals
signal damaged
signal swapped

#Party Properties 
var partyIndex = 0
var initial = true
var canAttack = true 

#Damage Properties 
export var meleeDamage = 10 
export var h_meleeKnockback = 40
export var v_meleeKnockback = -20
export var attackType = 'ranged'

#Player States 
var idleState
var moveState
var jumpState
var fallState 
var swapState
var damageState
var attackState 
var deathState

#Store our current State
var previousState 
var currentState

#Flag if checks for if out player is grounded 
onready var grounded = is_grounded()
onready var anim_players = $Anim_Players
onready var anim_player = $Anim_Players/Zulie_Anim_Player
onready var swap_Anim = $Anim_Players/Swap_Anim
onready var party = $Party

func _ready():
	#Set type
	type = 'PLAYER'
	
	#Set my camera 
	camera = get_node('../MainCamera')
	mainGUI = get_node("../MainCamera/HUD/Main_GUI")
	
	#Set the main camera 
	if(camera != null):
		if(camera.player == null):
			camera.player = self
		
	initializePlayer()
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

#Defer input to our state
func _input(event):
	currentState.handle_input(event)

#Handle exiting and entering new state
func set_state(newState):
	if(currentState != null && currentState.has_method('exit')):
		currentState.exit()
	previousState = currentState 
	currentState = newState
	currentState.enter()
	#print(currentState.get_name())
	
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
	deathState = $States/Death

	#Player animation 
	anim_player = anim_players.get_child(global.partyIndex)
	anim_player.visible = true
	
	#Initialize health and motion 
	currentHealth = global.playerCurrentHealth
	
	#Debug function 
func takeDamage(dam):
	#Apply Damage and check for death 
	party.party[partyIndex].currentHealth -= dam 
	currentHealth = party.party[partyIndex].currentHealth
	global.playerCurrentHealth = currentHealth
	match partyIndex:
		0:
			global.zulieHealth = currentHealth
		1: 
			global.astroHealth = currentHealth 
	emit_signal('damaged')

func _on_Swap_Anim_animation_finished(): 
	swap_Anim.stop()
	swap_Anim.frame = 0
	swap_Anim.visible = false 
	anim_player.visible = false
	party.swap(party.currentIndex, true)
	emit_signal('swapped')
