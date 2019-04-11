#Handle shooting logic for creating bullets 
#Assumptions
# 1. This node will be attatched to a parent and is not the root node 

extends Area2D

#Projectile Options 
export var projectile_scene = preload("res://Scenes/Player Objects/fireball-1.tscn")
export var charged_projectile = preload("res://Scenes/Player Objects/fireball-charged.tscn") 
export var cooldown = .5
export var projectile_speed = 400
export var chargeMax = 100 
export var chargeRate = 1 

var currentCharge = 0

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
		var creator = get_parent()
		timer.start()
		#Add the projectile to the scene 
		var projectile = null
		if(currentCharge < chargeMax):
			projectile = projectile_scene.instance(0)
		else:
			projectile = charged_projectile.instance(0)
			projectile.shakeAmplifier = currentCharge / 10
			
		projectile.creator = get_parent()
		get_parent().get_parent().add_child(projectile)
		
		#Setting projectile direction based on facing direction 
		if(creator.anim_player.flip_h):
			projectile.get_node('Sprite').flip_h = true
			projectile.set_speed(-projectile_speed)
		else:
			projectile.set_speed(projectile_speed)
		
		#Sets projectile position relative to the global position not the parent position 
		projectile.position = self.global_position
		
		currentCharge = 0
		
