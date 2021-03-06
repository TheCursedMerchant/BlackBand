
#This Script will hold all global values for the persisting game information 
extends Node

var player = null 
var current_scene = null
var spawnLocation : String = 'default'

#Global player variables 
var playerCurrentHealth = 100
var playerCurrentState = null
var partyIndex = 0 
var zulieHealth = 100
var astroHealth = 100
var playerCurrentFacingDir = dir.right
var currentCharacter = ""

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	call_deferred("_deferred_go_to_scene", path)
	
func _deferred_go_to_scene(path):
	
	if(player != null):
		player.despawn()
		
	#Delete the current scene
	current_scene.free()
	
	#Load the scene and assign to current_scene (Actually change scenes) 
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	
	#Adds the new scene as a child 
	get_tree().get_root().add_child(current_scene) 
	
	#Adds compatibility with the change_scene function API 
	get_tree().set_current_scene(current_scene)	

	

