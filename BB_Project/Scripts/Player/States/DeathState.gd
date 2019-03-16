extends 'res://Scripts/State.gd'


func get_name():
	return 'Death'
	
func enter():
	#For now just quit the game
	global.goto_scene('res://Scenes/Menus/Game Over Menu.tscn')
	