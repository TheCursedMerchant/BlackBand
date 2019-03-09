extends 'res://Scripts/State.gd'


func get_name():
	return 'Death'
	
func enter():
	#For now just quit the game
	get_tree().change_scene('res://Scenes/Menus/Game Over Menu.tscn')
	