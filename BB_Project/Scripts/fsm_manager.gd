extends Node

#This script will manage the transition between states 

#Defined States 
export (Array, NodePath) var statePaths 
var states = []

#Entity the state machine applies to
onready var target = get_parent() 

#Store our current State
var previousState 
var currentState

#Flag if checks for if out player is grounded 
onready var anim_players = $Anim_Players

func _ready():
	initializeStates(statePaths)
	if(states.size() > 0):
		currentState = states[0]
		set_state(currentState)
		
#Defer physics process to our state
func _physics_process(delta):
	currentState.update(delta)

#Defer input to our state
#Listens for inputs that can interrupt any other state 
func _input(event):
	currentState.handle_input(event)
	
func _unhandled_input(event):
	if(currentState.has_method("unhandled_input")):
		currentState.unhandled_input(event)

#Handle exiting and entering new state
func set_state(newState):
	if(currentState != newState):
		if(currentState != null && currentState.has_method('exit')):
			currentState.exit()
		previousState = currentState 
		currentState = newState
		currentState.enter()
		if(target.get("type") == "ENEMY"):
			print("Enemy entered the " + currentState.get_name() + " state.")
	
func initializeStates(statePaths):
	for state in statePaths:
		states.append(get_node(state))
		
#Custom find function for getting our states 
func findState(stateName):
	var index = 0
	if(states.size() > 0):
		for state in states:
			if(state.get_name() == stateName):
				return index
			else:
				index += 1



