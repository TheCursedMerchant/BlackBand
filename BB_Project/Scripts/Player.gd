extends KinematicBody2D

#Statistics
const MOVE_SPEED = 200
const JUMP_HEIGHT = -300
const GRAVITY_MULTIPLIER = 2.5 
const GRAVITY = 10
const UP = Vector2(0,-1)

#Properties
var motion = Vector2()

func _physics_process(delta):
	
	#Gravity
	motion.y += GRAVITY
	
	#Movement
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		$Sprite.play("Run")
		motion.x = MOVE_SPEED
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		$Sprite.play("Run")
		motion.x = -MOVE_SPEED
	else:
		$Sprite.play("Idle")
		motion.x = 0
		
		
	#Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else:
		if motion.y > 0:
			$Sprite.play("Fall")
			motion.y += GRAVITY * GRAVITY_MULTIPLIER * delta 
		else:
			$Sprite.play("Jump")
	
	#Apply Motion changes
	motion = move_and_slide(motion, UP)
#	
	#Read documentation on GD functions
	pass
