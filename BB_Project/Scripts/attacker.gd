extends Position2D

var timer = Timer.new()
var cooldown = .4
var swordBox = preload('res://Scenes/Player Objects/Sword-Box.tscn')
var direction = 1

export var x_offset = 15

func _ready():
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "on_attack_complete")
	add_child(timer)

func on_attack_complete():
	get_parent().canAttack = true
	
func attack():
		var creator = get_parent()
		timer.start()
		#Add the projectile to the scene 
		var hitBox = swordBox.instance(0)
		hitBox.creator = creator
		hitBox.damage = creator.meleeDamage
		hitBox.h_knockback = creator.h_meleeKnockback
		hitBox.v_knockback = creator.v_meleeKnockback
		creator.get_parent().add_child(hitBox)
	
		#Setting projectile direction based on facing direction 
		if(creator.anim_player.flip_h):
			direction = -1 
		else:
			direction = 1
		
		#Sets projectile position relative to the global position not the parent position 
		hitBox.position = self.global_position + Vector2(x_offset * direction, 0)
