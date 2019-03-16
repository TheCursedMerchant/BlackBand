
#This Script will hold all global values for the persisting game information 
extends Node

var current_scene = null

#Global player variables 
var playerCurrentHealth = 5 
var playerCurrentState = null   

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	call_deferred("_deferred_go_to_scene", path)
	
func _deferred_go_to_scene(path):
	
	#Delete the current scene
	current_scene.free()
	
	#Load the scene and assign to current_scene (Actually change scenes) 
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	
	#Adds the new scene as a child 
	get_tree().get_root().add_child(current_scene) 
	
	#Adds compatibility with the change_scene function API 
	get_tree().set_current_scene(current_scene)	

	

