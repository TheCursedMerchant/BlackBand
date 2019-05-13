extends "res://Scripts/State.gd"

var knife
var travelVector
var ray
var targetPosition 
var timer = Timer.new()
var cooldown = .5
var startingLoc = Vector2(0, 0)
var travelDistance = 0 

func get_name():
	return "Dash"
	
func enter():
	#Start throw timer 
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
	#Add reference to knife 
	knife = target.knife
	startingLoc = target.global_position
	
	#Ray cast logic 
	ray = target.knifeRay
	ray.set_cast_to(get_distance(target.global_position, knife.global_position))
	if(ray.is_colliding()):
		ray.set_cast_to(get_distance(target.global_position, ray.get_collision_point()))
	travelVector = ray.get_cast_to()
	target.grabTarget = travelVector
		
	#Reset motion so we don't keep any momentum 
	target.motion = Vector2(0, 0) 
	
func update(delta): 
	#Apply wall friction 
	if(target.is_on_wall()):
		target.motion.x = lerp(target.motion.x, 0, target.friction)
		
	#Move Astro 
	target.motion = target.move_and_slide(travelVector.normalized() * target.dashSpeed)
	
	#Update travel distance 
	travelDistance = target.global_position.distance_to(startingLoc) 
	
	#Check for collisions 
	for i in target.get_slide_count():
		var collision = target.get_slide_collision(i)
		if(collision.collider.get("type") != "GRAB"):
			manager.set_state(manager.states[manager.findState("Idle")])
			if(knife != null):
				knife.stateManager.set_state(knife.stateManager.states[knife.stateManager.findState("Idle")])
	
	#Check if Astro has gone to far 			
	if(travelDistance > travelVector.length()):
		manager.set_state(manager.states[manager.findState("Idle")])
			
			
func exit():
	target.motion = Vector2(0, 0)
	travelVector = Vector2(0, 0)
	ray.set_cast_to(Vector2(0, 0))

#Helper Functions 
func get_distance(startPosition, targetPosition):
	var x_pos = targetPosition.x - startPosition.x 
	var y_pos = targetPosition.y - startPosition.y
	return Vector2(x_pos, y_pos)

func on_timeout_complete():
	target.canThrow = true 