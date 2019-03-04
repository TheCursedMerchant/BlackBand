extends Node

#This is our singleton game object script 

onready var player = get_child(0)

func _ready():
	set_process_input(true) 
	pass
	
func _process(delta):
	pass 
	
func _input(event):
	if(event.is_action_pressed('ui_cancel')):
		quit()
	elif(event.is_action_pressed('ui_restart')):
		restart()
	elif(event.is_action_pressed('ui_damage')):
		player.takeDamage(1)
	
func quit():
	#TODO: Quit the game 
	get_tree().quit() 

func restart():
	get_tree().change_scene((get_tree().get_current_scene().get_filename()))
	print(get_tree().current_scene)
	
