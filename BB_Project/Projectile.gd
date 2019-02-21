extends Area2D

export var speed = 200
export var damage = 5
export var h_knockback = 20 
export var v_knockback = 0 

var knockbackDir
var creator = null
	
func _physics_process(delta):
	var speed_x = 1
	var speed_y = 0
	var motion = Vector2(speed_x, speed_y) * speed
	position += motion * delta

func get_speed():
	return speed
	
func set_speed(var s):
	speed = s

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Projectile_area_entered(area):
	queue_free()

func _on_Projectile_body_entered(body):
	if(body != creator):
		match body.get("type"):
			"ENEMY":
				if(body.currentState != body.damageState):
					body.currentDamage += damage
				
					#Check which direction we we're hit from 
					if(body.position.x < self.position.x):
						body.knockbackDir = -1
						body.anim_player.flip_h = false
					else:
						body.knockbackDir = 1
						body.anim_player.flip_h = true
						
					body.knockback = Vector2(h_knockback * body.knockbackDir, v_knockback)
					
					body.set_state(body.damageState)
			"PLAYER":
				if(body.currentState != body.damageState):
					body.currentDamage += damage
					#Check which direction we we're hit from 
					if(body.position.x < self.position.x):
						body.knockbackDir = 1
						body.anim_player.flip_h = false
					else:
						body.knockbackDir = -1
						body.anim_player.flip_h = true
						
					body.knockback = Vector2(h_knockback * knockbackDir, v_knockback)
					body.set_state(body.damageState)
		queue_free()
