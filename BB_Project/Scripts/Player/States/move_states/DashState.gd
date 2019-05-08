extends "res://Scripts/State.gd"

var knife
var travelVector
var ray
var targetPosition 
var jumpVector = Vector2(0, -20)
var timer = Timer.new()
var cooldown = .5

func get_name():
	return "Dash"
	
func enter():
	
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	knife = target.knife
	targetPosition = target.global_position
	
	ray = target.knifeRay
	ray.set_cast_to(get_distance(target.global_position, knife.global_position))
	if(ray.is_colliding()):
		ray.set_cast_to(get_distance(target.global_position, ray.get_collision_point()))
	travelVector = ray.get_cast_to()
			
	target.motion = Vector2(0, 0) 
	target.move_and_slide(jumpVector, dir.up)
	
func update(delta): 
	if(target.is_on_wall()):
		target.motion.x = lerp(target.motion.x, 0, target.friction)
	
	var collide = target.move_and_collide(travelVector.normalized() * target.dashSpeed)
	
	if(collide != null):
		if(collide.collider.get("type") == "GRAB"):
			manager.set_state(manager.states[manager.findState("Hang")])
		else:
			manager.set_state(manager.states[manager.findState("Idle")])
			if(knife != null):
				knife.stateManager.set_state(knife.stateManager.states[knife.stateManager.findState("Idle")])
			
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