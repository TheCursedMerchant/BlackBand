
#Base state class for entity states
extends Node

#Entity object the state will apply to 
#Assumes States Node Structure 
onready var manager = get_parent()
onready var target = get_parent().get_parent()

export var active : bool  

#Return the name of our state 
func get_name():
	return

#On State Enter
func enter():
	return

#State cleanup
func exit():
	return

#Handle Input
func handle_input(event):
	return
	
#Optional unhandled input 
func unhandled_input(event):
	pass

#Called every frame
func update(delta):
	return

#Allow control after animations
func _on_animation_end(anim):
	return
