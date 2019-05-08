extends "res://Scripts/State.gd"

var knifeCircleScene = preload("res://Scenes/GUI/Knife-Circle.tscn")
var knifeCircle 
var knife

func get_name():
	return "Aim"
	
func enter():
	#print("Player entered state: " + get_name())
	if(target.knifePosition.currentKnife != null):
		knife = target.knifePosition.currentKnife
		spawnCircle()
	
func update(delta):
	
	#Slide 
	target.motion.x = lerp(target.motion.x, 0, target.friction)
	
	#Check if entity is falling 
	if(!target.grounded):
		target.motion.y += target.gravity
		
	if(target.is_on_wall()):
		target.motion.x = lerp(target.motion.x, 0, target.friction)
			
	target.move_and_slide(target.motion, dir.up)
	
func handle_input(event):
	if(Input.is_action_just_released("special_01")):
		target.canThrow = false 
		target.stateManager.set_state(target.stateManager.states[target.stateManager.findState("Idle")])
		
	if(knife != null):
		if((Input.is_action_just_pressed("ui_right") || Input.is_action_just_pressed("ui_left") || 
		Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_down"))):
			knifeCircle.currentDirection = knife.facingDir
			knifeCircle.switchNode()
		elif(!(Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left") || 
		Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down"))):
			knifeCircle.currentDirection = Vector2(0, 0)
			knifeCircle.switchNode()
			
func exit():
	despawnCircle()
	
#Create knife Circle 
func spawnCircle():
	knifeCircle = knifeCircleScene.instance(0)
	target.knifeCircle = knifeCircle
	target.add_child(knifeCircle)

#Destory Knife Circle 
func despawnCircle():
	target.knifeCircle.queue_free()
	
	

