extends Control

onready var global = get_node("/root/global")

#Called when start button is pressed
func _on_Start_Game_pressed():
	global.goto_scene('res://Scenes/Levels/Demo.tscn')
	
#Called when quit button is pressed
func _on_Quit_Game_pressed():
	get_tree().quit()
