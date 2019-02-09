extends 'State.gd'
	
var cooldown = .5
var timer = null
	
func get_name():
	return 'Swap'
	
func enter():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	timer.start()
	
func update(delta):
	print(cooldown)
	
func exit():
	#TODO: Remove current character 
	entity.get_child(6).swap(entity.partyIndex, true) 

func on_timeout_complete():
	#Exit state
	print('Swap timer complete!') 
	exit()