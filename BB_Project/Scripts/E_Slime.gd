extends "./engine/entity.gd"

#Initialize Slime Enemy 
func _ready():
	currentHealth = health
	type = 'ENEMY'
	
func takeDamage(dam):
	currentHealth -= dam 
	if(currentHealth <= 0):
		queue_free()
	

