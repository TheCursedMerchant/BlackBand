extends "res://Scripts/State.gd"

const NO_DIR = Vector2(0,0) 
const X_TOLERANCE = .01 
const Y_TOLERANCE = .01

var user

func get_name():
	return "Aim"
	
func enter():
	user = target.user
	
func update(delta):
	target.position = target.followTarget.get_parent().position

func handle_input(event):
	
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var inputAxis = Vector2(horizontal, vertical)
	
	if((Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left") || 
		Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down"))):
		target.facingDir = normalize(inputAxis)
	else:
		target.facingDir = target.user.facingDir
		
	target.stickRay.set_cast_to(target.facingDir * target.stickLength)
	#target.stickRay.position += target.facingDir
	
	#On release throw the knife 
	if(!Input.is_action_pressed("special_01")):
		manager.set_state(manager.states[manager.findState("Throw")])
		if(target.facingDir.y == -1):
			user.throw_type = 2
		else:
			user.throw_type = 1
		user.stateManager.set_state(user.stateManager.states[user.stateManager.findState("Throw")])
	
#Custom normalization (yes I know it isn't true normalized but it works for me so shut up)
func normalize(vector : Vector2):
	#Fix the x value to 1, -1, or 0
	if(vector.x > X_TOLERANCE):
		vector.x = 1
	elif(vector.x < -X_TOLERANCE):
		vector.x = -1
	else:
		vector.x = 0
	#Fix the y value to 1, -1, or 0
	if(vector.y > Y_TOLERANCE):
		vector.y = 1
	elif(vector.y < -Y_TOLERANCE):
		vector.y = -1
	else:
		vector.y = 0
		
	return vector

	
	

