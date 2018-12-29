extends KinematicBody2D

#Statistics
const MAX_SPEED = 150
const JUMP_HEIGHT = -200
const GRAVITY_MULTIPLIER = 2.5 
const GRAVITY = 10
const UP = Vector2(0,-1)
const ACCELERATION = 50

#Properties
var motion = Vector2()

func _physics_process(delta):
	
	#Gravity
	motion.y += GRAVITY
	
	#Fricion
	var friction = false
	
	#Movement
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		$Sprite.play("Run")
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		$Sprite.play("Run")
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	else:
		$Sprite.play("Idle")
		friction = true
	
	#Jump and Apply Friction
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
	else:
		#Checks if character is falling 
		if motion.y > 0:
			$Sprite.play("Fall")
			#motion.y += GRAVITY * GRAVITY_MULTIPLIER * delta 
		else:
			$Sprite.play("Jump")
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05)
	
	#Apply Motion changes
	motion = move_and_slide(motion, UP)
	
#	
	#Read documentation on GD functions
	pass
