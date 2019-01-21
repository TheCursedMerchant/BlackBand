extends "res://Scripts/engine/entity.gd"

#Statistics
const PROJECTILE_SPEED = 200

#Projectile
const PROJECTILE_SCENE = preload("res://Scenes/projectile_scene.tscn") 
var timer = null
var cooldown = .5
var can_shoot = true

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
	
func _process(delta):
	#Get Input
	controls.getInput()
	checkDeath()
	
func _physics_process(delta):
	
	#Gravity
	motion.y += gravity
	
	#Fricion
	var friction = false
	
	#Movement
	if controls.RIGHT:
		$Sprite.flip_h = false
		$Sprite.play("Run")
		motion = move(motion, acceleration, maxSpeed, dir.right)
	elif controls.LEFT:
		$Sprite.flip_h = true
		$Sprite.play("Run")
		motion = move(motion, acceleration, maxSpeed, dir.left)
	else:
		$Sprite.play("Idle")
		friction = true
	
	#Jump and Apply Friction
	if is_on_floor():
		if controls.UP:
			motion.y = jumpHeight
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
	motion = move_and_slide(motion, dir.up)
	
	#Shooting logic 
	if controls.ATTACK && can_shoot:
		shoot()
		can_shoot = false
		timer.start()
	
	#print(str(timer.get_time_left()))
	
	#Read documentation on GD functions
	pass

#Shooting 
func shoot():
	
		#Add the projectile to the scene 
		var projectile = PROJECTILE_SCENE.instance(0)
		projectile.creator = self
		get_parent().add_child(projectile)
		
		#Setting projectile direction based on facing direction 
		if($Sprite.flip_h):
			projectile.set_speed(-PROJECTILE_SPEED)
		else:
			projectile.set_speed(PROJECTILE_SPEED)
		
		#Sets projectile position relative to the global position not the parent position 
		projectile.position = get_node("Position2D").global_position
		
#When wait time is completed do this
func on_timeout_complete():
	can_shoot = true
	
func jump(var motion, var height):
	motion.y = height
	return motion
