extends Control

func _ready():
	Transition.fade_in()
	
#Called when start button is pressed
func _on_Start_Game_pressed():
	Transition.fade_to('res://Scenes/Levels/Demo.tscn')
	
#Called when quit button is pressed
func _on_Quit_Game_pressed():
	get_tree().quit()
