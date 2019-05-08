extends Area2D

enum STATES { IDLE, ATTACK }

export var power = 10 
export var knockback = 10

var knockbackDir
var currentState
var idleState
var attackState

onready var anim_player = $"Sword-Anim"

var creator

func _ready():
	idleState = $States/Idle
	attackState = $States/Attack
	creator = get_parent()
	
	set_state(idleState) 
	
func _physics_process(delta):
	currentState.update(delta)
	anim_player.play(currentState.get_name())
	
func _input(event):
	currentState.handle_input(event)
	
func set_state(newState):
	if(currentState != null && currentState.has_method('exit')):
		currentState.exit()
	currentState = newState
	currentState.enter()
	
func _on_Sword_body_entered(body):
	#print('HIT!')
	if(body != creator):
		match body.get("type"):
			"ENEMY":
				if(body.currentState != body.damageState):
					body.currentDamage += power
					body.knockback = knockback
					#Check which direction we we're hit from 
					if(body.position.x < self.position.x):
						body.knockbackDir = -1
					else:
						body.knockbackDir = 1
						
					body.set_state(body.damageState)
			"PLAYER":
				if(body.currentState != body.damageState):
					body.currentDamage += power
					body.knockback = knockback
					#Check which direction we we're hit from 
					if(body.position.x < self.position.x):
						body.knockbackDir = 1
					else:
						body.knockbackDir = -1
					body.set_state(body.damageState)
