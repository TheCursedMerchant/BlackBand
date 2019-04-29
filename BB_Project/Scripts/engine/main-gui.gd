extends Control

onready var healthbar = $Meters/health
		
func _ready():
	Transition.fade_in()
	
func update_gui(player):
	var current = player.currentHealth * 1.0
	var total = player.health * 1.0
	healthbar.value = (current / total) * 100.00 