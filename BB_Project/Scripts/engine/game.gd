extends Node

#This is our singleton game object script 
onready var playerRes = load('res://Scenes/Player Objects/Player.tscn')
onready var player = get_node('Player') 

#Fill this with all spawnLocations in the current room 
onready var spawnLocations = get_tree().get_nodes_in_group('SPAWN')
onready var mainCamera = get_node('MainCamera')
onready var mainGUI = get_node('MainCamera/HUD/Main_GUI')

var currentInteractable = null 

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
		player.currentDamage = 50; 
		player.knockback = Vector2(-20, -25)
		player.stateManager.set_state(player.stateManager.states[player.stateManager.findState("Damage")])
	
	if(event.is_action_pressed("ui_up")):
		if(currentInteractable != null):
			currentInteractable.action()

func quit():
	#Quit the game 
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
			mainGUI.update_gui(newPlayer)
			connectPlayer()
			mainCamera.player = player

func connectPlayer():
	if(player != null):
		player.connect('damaged', self, 'on_Player_damaged')
		player.connect('swapped', self, 'on_Player_swapped')

#Event Handlers
func on_Player_damaged():
	mainGUI.update_gui(player)

func on_Player_swapped():
	mainGUI.update_gui(player)
