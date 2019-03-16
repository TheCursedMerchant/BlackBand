extends Node

#This is our singleton game object script 
onready var player = get_node('Player')

func _ready():
	set_process_input(true) 
	pass
	
func _input(event):
	if(event.is_action_pressed('ui_cancel')):
		quit()
	elif(event.is_action_pressed('ui_restart')):
		restart()
	elif(event.is_action_pressed('ui_damage')):
		player.currentDamage = 1; 
		player.knockback = Vector2(-20, -25)
		player.set_state(player.damageState)
	
func quit():
	#TODO: Quit the game 
	get_tree().quit() 

func restart():
	global.goto_scene((get_tree().get_current_scene().get_filename()))
	
	
	
