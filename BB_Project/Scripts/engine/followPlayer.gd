extends Camera2D

var player = null 

func _physics_process(delta):
	if(player != null):
		position.x = player.global_position.x 
		position.y = player.global_position.y 
	