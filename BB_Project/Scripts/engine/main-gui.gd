extends Control

var player = null
onready var healthbar = $Meters/health

func _ready():
	if(player != null):
		var current = player.currentHealth * 1.0
		var total = player.health * 1.0
		healthbar.value = (current / total) * 100.00 
		player.connect("playerDamaged", self, "_on_Player_playerDamaged")
		player.connect("playerSwapped", self, "_on_Player_playerSwapped")
		

func _on_Player_playerDamaged():
	if(player != null):
		var current = player.currentHealth * 1.0
		var total = player.health * 1.0
		healthbar.value = (current / total) * 100.00
		
func _on_Player_playerSwapped():
	if(player != null):
		var current = player.currentHealth * 1.0
		var total = player.health * 1.0
		healthbar.value = (current / total) * 100.00
