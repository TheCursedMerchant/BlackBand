#Abstract Class for all damage dealing objects 
extends Area2D

export var damage = 5
export var knock_back = 20 
var creator = null

func _on_Damage_area_entered(area):
	queue_free()
	area.queue_free()

#Handle entities entering our area 2D 
func _on_Damage_body_entered(body):
	if(body != creator):
		match body.get("type"):
			"ENEMY":
				if(body.currentState != body.damageState):
					body.currentDamage += damage
					body.knockback = knock_back
					#Check which direction we we're hit from 
					if(body.position.x < self.position.x):
						body.knockbackDir = -1
					else:
						body.knockbackDir = 1
						
					body.set_state(body.damageState)
			"PLAYER":
				if(body.currentState != body.damageState):
					body.currentDamage += damage
					body.knockback = knock_back
					#Check which direction we we're hit from 
					if(body.position.x < self.position.x):
						body.knockbackDir = 1
					else:
						body.knockbackDir = -1
					body.set_state(body.damageState)
		queue_free()


