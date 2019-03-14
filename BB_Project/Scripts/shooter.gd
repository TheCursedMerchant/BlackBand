#Handle shooting logic for creating bullets 
#Assumptions
# 1. This node will be attatched to a parent and is not the root node 

extends Area2D

#Projectile Options 
export var projectile_scene = preload("res://Scenes/Player Objects/fireball-1.tscn") 
export var cooldown = .5
export var projectile_speed = 400

#Logic Variables 
var timer = null

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
#--------- Shooting Cooldown ---------------------------------
func on_timeout_complete():
	get_parent().canAttack = true
		
#---------------------- Shooting ---------------------------------------------
func shoot():
	
		timer.start()
		#Add the projectile to the scene 
		var projectile = projectile_scene.instance(0)
		projectile.creator = get_parent()
		get_parent().get_parent().add_child(projectile)
		
		#Setting projectile direction based on facing direction 
		if(get_parent().anim_player.flip_h):
			projectile.set_speed(-projectile_speed)
		else:
			projectile.set_speed(projectile_speed)
		
		#Sets projectile position relative to the global position not the parent position 
		projectile.position = self.global_position
