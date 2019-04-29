
#This root player object will dynamically load player objects as they are needed 
#It will also act as the root node that all physics processes effect 
extends 'res://Scripts/engine/entity.gd'

#Signals
signal damaged
signal swapped

#Party Properties 
onready var partyIndex = global.partyIndex
var initial = true
var canAttack = true 
var canSwap = true 

#Damage Properties 
export var meleeDamage = 10 
export var h_meleeKnockback = 40
export var v_meleeKnockback = -20
export var attackType = 'ranged'

#Flag if checks for if out player is grounded 
onready var grounded = is_grounded()
onready var anim_players = $Anim_Players
onready var anim_player = $Anim_Players/Zulie_Anim_Player
onready var party = $Party
onready var shooter = $"shoot-point"
onready var frontRay = $front_ray
onready var knifePosition = $"Knife-Position"
onready var stateManager = $States

func _ready():
	#Set type
	type = 'PLAYER'
	name = 'Zulie'
	#Set my camera 
	camera = get_node('../MainCamera')
	mainGUI = get_node("../MainCamera/HUD/Main_GUI")
	#Set the main camera 
	if(camera != null):
		if(camera.player == null):
			camera.player = self
	initializePlayer()
		
#Defer physics process to our state
func _physics_process(delta):
	is_grounded()
	anim_player.play(stateManager.currentState.get_name())
	
#Check if player is on the ground 
func is_grounded():
	if($front_ray.is_colliding() || $back_ray.is_colliding()):
		if((frontRay.get_collider().get('type') == 'ONEWAY' && motion.y > 0) || (frontRay.get_collider().get('type') != 'ONEWAY')):
			grounded = true
	else:
		grounded = false
		
func _input(event):
	if(Input.is_action_just_released("ui_attack") && attackType == "ranged"):
		stateManager.set_state(stateManager.states[stateManager.findState("Attack")])
		return
		
func initializePlayer():
	#Player animation 
	anim_player = anim_players.get_child(global.partyIndex)
	anim_player.visible = true
	facingDir = global.playerCurrentFacingDir
	if(facingDir == dir.right):
		anim_player.flip_h = false 
	else:
		anim_player.flip_h = true 
	
	#Initialize health and motion 
	currentHealth = global.playerCurrentHealth
	
	#Load character info
	party.loadCharacterInfo(party.party[partyIndex])
	
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
