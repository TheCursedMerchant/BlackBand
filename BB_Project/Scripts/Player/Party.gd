
#This node assumes that it is a child node of the player 
extends Node

var party = []
var cooldown = .5 
var timer = null
var canSwap = true 

#Initialize the party
func _ready():
	party.append(load('res://Scenes/Player.tscn'))
	party.append(load('res://Scenes/Player-Alt.tscn'))
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
func on_timeout_complete():
	canSwap = true 

func swap(index, forward):
	
	if(canSwap):
		
		canSwap = false 
		
		var nextChar
		var newIndex 
		
		#Check which index to switch too
		if(party.size() >= 2):
			if(forward):
				if(index + 1 < party.size()):
					newIndex = index + 1
				else:
					newIndex = index - 1
			else:
				if(index - 1 >= 0):
					newIndex = index - 1  
				else:
					newIndex = index + 1
					
			#Add next character to the scene 
			nextChar = party[newIndex].instance(0)
			get_node("../../MainCamera").player = nextChar
			nextChar.currentHealth = get_parent().currentHealth
			nextChar.motion = get_parent().motion
			nextChar.facingDir = get_parent().facingDir
			nextChar.get_node('Player_Anim').flip_h = get_parent().get_child(0).flip_h
			get_node('../..').add_child(nextChar)
			nextChar.position = get_parent().global_position
			
			timer.start()
	
			#Remove Original Character 	
			get_parent().queue_free()
		
