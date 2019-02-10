extends 'res://Scripts/State.gd'

func get_name():
	return 'Idle'
	
func enter():
	entity.motion = Vector2()
	
func update(delta):
	if(!entity.grounded):
		entity.set_state(entity.fallState)


