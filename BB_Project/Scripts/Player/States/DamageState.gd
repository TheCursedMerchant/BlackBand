extends '../../State.gd'

var timer = null

func get_name():
	return 'Damage'

func enter():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(target.damageTime)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	target.takeDamage(target.currentDamage)
	
func update(delta):
	#Apply knockback 
	target.motion = target.knockback 
	target.move_and_slide(target.motion, dir.up) 
	
	if(target.currentHealth <= 0):
		manager.set_state(manager.states[manager.findState("Death")])
	
#Reduce stored damage
func exit():
	target.motion = Vector2(0, 0) 
	target.currentDamage = 0
	
func on_timeout_complete():
	if(target.get("type") == 'ENEMY'):
		manager.set_state(manager.states[manager.findState("Chase")])
	else:
		manager.set_state(manager.previousState)
	

