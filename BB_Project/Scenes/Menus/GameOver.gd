extends Control

func _on_Retry_pressed():
	get_tree().change_scene('res://Scenes/Levels/Demo.tscn')
	
func _on_Quit_pressed():
	get_tree().quit()
