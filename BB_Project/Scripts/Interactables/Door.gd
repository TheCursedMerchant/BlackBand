extends Area2D

var game = null 
var global = null
export var nextLocation = 'door'
export var scene = 'res://Scenes/Levels/Demo-1-2BAD.tscn'
var player = null 

func _ready():
	global = get_node("/root/global")

func _on_Door_body_entered(body):
	if(body.get('type') == 'PLAYER'):
		game = get_parent()
		if(game != null):
			player = body
			game.currentInteractable = self
		
func change_rooms(player, scene):
	global.playerCurrentHealth = player.currentHealth
	global.playerCurrentFacingDir = player.facingDir
	global.spawnLocation = nextLocation
	global.goto_scene(scene)
	
func action():
	change_rooms(player, scene)

func _on_Door_body_exited(body):
	game.currentInteractable = null 
