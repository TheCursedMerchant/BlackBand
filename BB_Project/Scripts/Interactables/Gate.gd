extends StaticBody2D

export var moveSpeed = .5
export var travelDistance = 150
export var vertical = false
export var cooldown : float = 2.0
export var openDirection = 1

var motion = Vector2()
var open = false 
var stop = true  
var timer = null
var type = 'SOLID'
var moveType = 'MOVING'

signal gateStopped

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)

func _physics_process(delta):
	
	if(!stop):
		if(open):
			if(vertical):
				motion.y = lerp(motion.y, travelDistance * openDirection, moveSpeed)
			else:
				motion.x = lerp(motion.x, travelDistance * openDirection, moveSpeed)
		else:
			if(vertical):
				motion.y = lerp(motion.y, travelDistance * -openDirection, moveSpeed)
			else:
				motion.x = lerp(motion.x, travelDistance * -openDirection, moveSpeed)
			
		position += motion * delta
		
	if(abs(motion.y) >= travelDistance || abs(motion.x) >= travelDistance):
		stop = true
		motion = Vector2()
		emit_signal("gateStopped")
			
func _on_Pulley_area_entered(area):
	if(area.get('type') == 'fireball' && stop == true && open == false):
		stop = false 
		open = true
		timer.start()
		
func on_timeout_complete():
	stop = false 
	open = !open
	



func _on_Pulley_02_area_entered(area):
	pass # Replace with function body.
