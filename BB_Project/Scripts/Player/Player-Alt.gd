extends 'res://Scripts/Player/Player.gd'

#Initialize our state
func _ready():
	
	#Set my camera 
	camera = get_node('../MainCamera')
	
	#Set entity type 
	type = 'PLAYER'
	
	#Set Party Index 
	partyIndex = 1
	
	#Turn off Shooter 
	$"shoot-point".can_shoot = false
	
	#Turn on melee attack 
	canAttack = true
	
	#Initialize Player
	initializePlayer()
	
	#Enter idle state
	set_state(idleState)
	
func _input(event):
	currentState.handle_input(event)
	
