extends Area2D

#Custom Properties 
export var throwDistance = Vector2(100, 100) 
export var throwSpeed = 20
export var moveSpeed = 20
export var followPercent = .1
export var stickLength = 10 
export var followDistance = 200 

#Code dependent properties 
var facingDir = dir.right
var followTarget
var user 
var weakGrabRef = null 
var distanceToUser = 0 

onready var animPlayer = $AnimPlayer
onready var stateManager = $StateMachine
onready var colShape = $CollisionShape2D
onready var grabPoint = $"Grab-Point"
onready var stickRay = $stickRay

#Go to my target position if I was given one 
func _ready():
	if(followTarget != null):
		position = followTarget.global_position
		
func _process(delta):
	if(user != null && stateManager.currentState.get_name() == "Stick"):
		distanceToUser = self.global_position.distance_to(user.global_position)
		if(distanceToUser >  followDistance):
			stateManager.set_state(stateManager.states[stateManager.findState("Return")])
			return 
			

func _on_Knife_area_entered(area):
#	if(stateManager.currentState.get_name() == "Throw" && area.get("type") == "SOLID"):
##		print("HIT AREA!")
#		stateManager.set_state(stateManager.states[stateManager.findState("Stick")])
	pass

func _on_Knife_body_entered(body):
#	if(stateManager.currentState.get_name() == "Throw" && body != user):
##		print("HIT BODY!")
#		stateManager.set_state(stateManager.states[stateManager.findState("Stick")])
	if(stateManager.currentState.get_name() == "Stop" && body == user):
		stateManager.set_state(stateManager.states[stateManager.findState("Idle")])
		

