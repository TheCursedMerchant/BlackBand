extends Node

#This is our singleton game object script 
onready var player = load('res://Scenes/Player Objects/Player.tscn')

#Fill this with all spawnLocations in the current room 
onready var spawnLocations = get_tree().get_nodes_in_group('SPAWN')

func _ready():
	set_process_input(true) 
	#Spawn the player 
	if(get_node('Player') == null):
		spawnPlayer(global.spawnLocation)
	
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
	
func spawnPlayer(location):
	#Based on location spawn a player at corresponding location 
	for spawner in spawnLocations:
		if(spawner.location == location):
			var newPlayer = player.instance(0)
			newPlayer.position.x = spawner.global_position.x
			newPlayer.position.y = spawner.global_position.y
			add_child(newPlayer)
	
	
	
