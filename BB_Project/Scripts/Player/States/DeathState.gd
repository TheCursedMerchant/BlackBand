extends 'res://Scripts/State.gd'


func get_name():
	return 'Death'
	
func enter():
	#For now just quit the game
	if(entity.type == 'PLAYER'):
		global.playerCurrentHealth = entity.health
		global.goto_scene('res://Scenes/Menus/Game Over Menu.tscn')
	