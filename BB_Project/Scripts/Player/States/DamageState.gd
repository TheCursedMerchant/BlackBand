extends '../../State.gd'

var timer = null

func get_name():
	return 'Damage'

func enter():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(entity.damageTime)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	
func update(delta):
	#Apply knockback 
	entity.motion = entity.knockback 
	entity.move_and_slide(entity.motion, dir.up) 
	
#Reduce stored damage
func exit():
	entity.motion = Vector2(0, 0) 
	entity.takeDamage(entity.currentDamage)
	print(entity.currentHealth)
	entity.currentDamage = 0
	
func on_timeout_complete():
	entity.set_state(entity.previousState)
	

