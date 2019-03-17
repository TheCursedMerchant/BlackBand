extends Node

#This is our singleton game object script 
onready var playerRes = load('res://Scenes/Player Objects/Player.tscn')
onready var player = get_node('Player') 

#Fill this with all spawnLocations in the current room 
onready var spawnLocations = get_tree().get_nodes_in_group('SPAWN')
onready var mainCamera = get_node('MainCamera')
onready var mainGUI = get_node('MainCamera/HUD/Main_GUI')

func _ready():
	set_process_input(true) 
	#Spawn the player 
	if(get_node('Player') == null):
		spawnPlayer(global.spawnLocation)
	mainCamera.player = player
	mainGUI.player = player
	
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
			var newPlayer = playerRes.instance(0)
			player = newPlayer
			newPlayer.position.x = spawner.global_position.x
			newPlayer.position.y = spawner.global_position.y
			add_child(newPlayer)
	
	
	
