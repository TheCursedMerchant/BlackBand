extends Control

onready var healthbar = $Meters/health
	
func update_gui(player):
	print('GUI Updated')
	var current = player.currentHealth * 1.0
	print('Player current health: ' + str(current))
	var total = player.health * 1.0
	print('Player total health: ' + str(total))
	healthbar.value = (current / total) * 100.00 
		
