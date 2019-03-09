extends 'res://Scripts/State.gd'

func get_name():
	return 'Death' 
	
func enter():
	queue_free()