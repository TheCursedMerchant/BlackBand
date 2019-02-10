extends Area2D

export var speed = 200
export var damage = 5
export var knock_back = 20 
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
	area.queue_free()

func _on_Projectile_body_entered(body):
	if(body != creator):
		if(body.currentState != body.damageState):
			match body.get("type"):
				"ENEMY":
					body.currentDamage += damage
					body.knockback = knock_back
					#Check which direction we we're hit from 
					if(body.position.x < self.position.x):
						body.knockbackDir = -1
					else:
						body.knockbackDir = 1
						
					body.set_state(body.damageState)
				"PLAYER":
					body.currentDamage += damage
					body.knockback = knock_back
					#Check which direction we we're hit from 
					if(body.position.x < self.position.x):
						body.knockbackDir = 1
					else:
						body.knockbackDir = -1
					body.set_state(body.damageState)
		queue_free()
