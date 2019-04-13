extends StaticBody2D

export var moveSpeed = .5
export var travelDistance = 150

var motion = Vector2()
var open = false 
var stop = true  
var timer = null
export var cooldown : float = 2.0
var type = 'SOLID'

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
			motion.y = lerp(motion.y, -travelDistance, moveSpeed)
		else:
			motion.y = lerp(motion.y, travelDistance, moveSpeed)
			
		position += motion * delta
		
	if(abs(motion.y) >= travelDistance):
		stop = true
		motion.y = 0
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
