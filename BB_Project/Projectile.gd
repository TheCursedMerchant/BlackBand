extends Area2D

var speed = 200
var damage = 5
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
		match body.get("type"):
			"ENEMY":
				body.currentHealth -= damage
				print(str(body.currentHealth))
			"PLAYER":
				body.currentHealth -= damage
				print(str(body.currentHealth))
		queue_free()
