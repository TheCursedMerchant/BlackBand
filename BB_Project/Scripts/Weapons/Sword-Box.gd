extends Area2D

var damage 
var h_knockback 
var v_knockback
var knockbackDir
var creator
var timer = null 
var lifeTime = .5

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(lifeTime)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	
func on_timeout_complete():
	queue_free() 

func _on_SwordBox_body_entered(body):
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
	
