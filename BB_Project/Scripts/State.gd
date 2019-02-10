
#Base state class for entity states
extends Node

#Entity object the state will apply to 
#Assumes States Node Structure 
onready var entity = get_parent().get_parent()

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

#Called every frame
func update(delta):
	return

#Allow control after animations
func _on_animation_end(anim):
	return
