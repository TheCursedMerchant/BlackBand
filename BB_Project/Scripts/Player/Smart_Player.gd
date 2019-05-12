#This root player object will dynamically load player objects as they are needed 
#It will also act as the root node that all physics processes effect 
extends 'res://Scripts/engine/entity.gd'

#Signals
signal damaged
signal swapped

#Party Properties 
onready var partyIndex = global.partyIndex
onready var currentCharacter = global.currentCharacter 
var initial = true
var canAttack = true 
var canSwap = true 
var canThrow = true 
var grabTarget = null 

#Statistics Properties 
export var meleeDamage = 10 
export var h_meleeKnockback = 40
export var v_meleeKnockback = -20
export var attackType = 'ranged'
export var dashSpeed = 40
export var maxDashSpeed = 360

#Flag if checks for if out player is grounded 
onready var grounded = is_grounded()
onready var anim_players = $Anim_Players
onready var anim_player = $Anim_Players/Zulie_Anim_Player
onready var party = $Party
onready var shooter = $"shoot-point"
onready var frontRay = $front_ray
onready var knifePosition = $"Knife-Position"
onready var knifeCircle = $"Knife-Circle"
onready var stateManager = $States
onready var knifeRay = $"Knife-Ray" 
var knife = null 

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
	if(!stateManager.currentState.active):
		if(Input.is_action_just_released("ui_attack") && attackType == "ranged"):
			stateManager.set_state(stateManager.states[stateManager.findState("Attack")])
			return
		if(knife != null):
			if(Input.is_action_just_pressed('special_01') && currentCharacter == 'Astro'):
				if(knife.stateManager.currentState.get_name() == "Stick"):
					 stateManager.set_state(stateManager.states[stateManager.findState("Dash")])
					 return
				elif(canThrow && knife.stateManager.currentState.get_name() == "Aim"):
					stateManager.set_state(stateManager.states[stateManager.findState("Aim")])
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

func createKnifeRay():
	var newRay = RayCast2D.new()
	get_tree().get_root().add_child(newRay)
	knifeRay = newRay
	