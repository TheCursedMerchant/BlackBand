extends Control

var player = null 
onready var healthbar = $Meters/health

func _ready():
	if(player != null):
		var current = player.currentHealth * 1.0
		var total = player.health * 1.0
		healthbar.value = (current / total) * 100.00 
		
