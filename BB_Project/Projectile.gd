extends Area2D

export var speed = 200
export var damage = 5
export var h_knockback = 20 
export var v_knockback = 0 

var shakeAmplifier = 1
var knockbackDir = dir.right
var creator = null
var speed_x = 1
var speed_y = 0
var hit = false 
var type = 'fireball'
var currentAnim : String = 'move'
	
func _process(delta):
	$Sprite.play(currentAnim)
	
func _physics_process(delta):
	var motion = Vector2(speed_x, speed_y) * speed
	position += motion * delta
		
func stop_destroy():
	speed_x = 0
	currentAnim = 'destroy'

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
		
func _on_Projectile_body_entered(body):
	if(body != creator && !hit):
		hit = true
		match body.get("type"):
			"ENEMY":
				damageEnemy(body)	
			"PLAYER":
				damagePlayer(body)
		
		stop_destroy()
		
				
func _on_Sprite_animation_finished():
	if(currentAnim == 'destroy'):
		queue_free()

func _on_Projectile_area_entered(area):
	if(area != creator && !hit):
		hit = true
		match area.get("type"):
			"SOLID":
				stop_destroy()
			"BREAKABLE":
				area.destroy()
				stop_destroy()
		
func damageEnemy(body):
	#Shake screen
		body.camera.shake(0.2 * shakeAmplifier , 15 * shakeAmplifier, 8 * shakeAmplifier)
			
		if(body.currentState != body.damageState):
			body.currentDamage += damage
			#Check which direction we we're hit from 
			if(body.position.x < self.position.x):
				body.knockbackDir = -1
				body.anim_player.flip_h = false
				body.facingDir = dir.right
				body.floor_checker.position.x = body.maxSpeed/2
			else:
				body.knockbackDir = 1
				body.anim_player.flip_h = true
				body.facingDir = dir.left
				body.floor_checker.position.x = -body.maxSpeed/2
				
			body.knockback = Vector2(h_knockback * body.knockbackDir, v_knockback)
			body.set_state(body.damageState)

func damagePlayer(body):
	if(body.currentState != body.damageState):
					
		#Shake screen
		body.camera.shake(0.2, 15, 8)
		body.currentDamage += damage
		#Check which direction we we're hit from 
		if(body.position.x < self.position.x):
			body.knockbackDir = 1
			body.anim_player.flip_h = false
		else:
			body.knockbackDir = -1
			body.anim_player.flip_h = true
			
		body.knockback = Vector2(h_knockback * body.knockbackDir, v_knockback)
		body.set_state(body.damageState)
