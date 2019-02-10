extends '../../State.gd'

var timer = null

func get_name():
	return 'Damage'

func enter():
	entity.takeDamage(entity.currentDamage)
	print(entity.currentHealth)
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(entity.damageTime)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	
func update(delta):
	#Apply knockback 
	entity.motion.x += entity.knockback * entity.knockbackDir
	entity.move_and_slide(entity.motion, dir.up) 
	
#Reduce stored damage
func exit():
	entity.currentDamage = 0
	
func on_timeout_complete():
	entity.set_state(entity.idleState)
	

