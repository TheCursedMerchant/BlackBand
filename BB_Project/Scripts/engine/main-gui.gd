extends Control

var player = null 
onready var game = get_tree().get_root()
onready var healthbar = $Meters/health

func _ready():
	#Listen for game signals
	print(game.has_method('restart'))
	game.connect("playerSpawned", self, "_on_Game_playerSpawned")
	
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

func _on_Game_playerSpawned():
	print('CMON YOU BITCH!')
	player = game.player 
	var current = player.currentHealth * 1.0
	var total = player.health * 1.0
	healthbar.value = (current / total) * 100.00
