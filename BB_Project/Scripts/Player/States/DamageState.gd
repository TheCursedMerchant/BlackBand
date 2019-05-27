extends '../../State.gd'

var timer = Timer.new()

func get_name():
	return 'Damage'

func ready():
	timer.set_one_shot(true)
	timer.set_wait_time(target.damageTime)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)

func enter():
	timer.start()
	target.takeDamage(target.currentDamage)
	
func update(delta):
	#Apply knockback 
	target.motion = target.knockback 
	target.move_and_slide(target.motion, dir.up) 
	
	if(target.currentDamage >= target.resistance):
		manager.set_state(manager.states[manager.findState("Exhaust")])
	
	if(target.currentHealth <= 0):
		manager.set_state(manager.states[manager.findState("Death")])
	
#Reduce stored damage
func exit():
	timer.stop()
	target.motion = Vector2(0, 0) 
	
func on_timeout_complete():
	if(target.get("type") == 'ENEMY'):
		target.currentDamage = 0
		manager.set_state(manager.states[manager.findState("Chase")])
	else:
		manager.set_state(manager.previousState)
	

