extends Position2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var timer = null
var cooldown = .4
var swordBox = preload('res://Scenes/Sword-Box.tscn')
var direction = 1

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "on_attack_complete")
	add_child(timer)

func on_attack_complete():
	get_parent().canAttack = true
	
func attack():
		timer.start()
		#Add the projectile to the scene 
		var hitBox = swordBox.instance(0)
		hitBox.creator = get_parent()
		hitBox.damage = get_parent().meleeDamage
		hitBox.knockback = get_parent().meleeKnockback
		get_parent().get_parent().add_child(hitBox)
	
		#Setting projectile direction based on facing direction 
		if(get_parent().anim_player.flip_h):
			direction = -1 
		else:
			direction = 1
		
		#Sets projectile position relative to the global position not the parent position 
		hitBox.position = self.global_position + Vector2(20 * direction, 0)
