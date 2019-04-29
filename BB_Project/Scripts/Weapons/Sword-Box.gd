extends Area2D

var damage 
var h_knockback 
var v_knockback
var knockbackDir
var creatorType
var timer = null 
var lifeTime = .1

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
	if(body.get("type") != creatorType):
		match body.get("type"):
			"ENEMY":
				#Shake screen
				body.camera.shake(0.2, 15, 8)
				if(body.stateManager.currentState != body.stateManager.states[body.stateManager.findState("Damage")]):
					body.currentDamage += damage
					#Check which direction we we're hit from 
					if(body.position.x < self.position.x):
						body.knockbackDir = -1
						body.anim_player.flip_h = false
					else:
						body.knockbackDir = 1
						body.anim_player.flip_h = true
						
					body.knockback = Vector2(h_knockback * body.knockbackDir, v_knockback)
						
					body.stateManager.set_state(body.stateManager.states[body.stateManager.findState("Damage")])
			"PLAYER":
				#Shake screen
				body.camera.shake(0.4, 18, 10)
				if(body.stateManager.currentState != body.stateManager.states[body.stateManager.findState("Damage")]):
					body.currentDamage += damage
					#Check which direction we we're hit from 
					if(body.position.x < self.position.x):
						body.knockbackDir = 1
						body.anim_player.flip_h = false
					else:
						body.knockbackDir = -1
						body.anim_player.flip_h = true
						
					body.knockback = Vector2(h_knockback * knockbackDir, v_knockback)
					
					body.stateManager.set_state(body.stateManager.states[body.stateManager.findState("Damage")])
		queue_free()
	
