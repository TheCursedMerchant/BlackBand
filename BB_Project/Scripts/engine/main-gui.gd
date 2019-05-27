extends Control

onready var healthbar = $Meters/health
onready var manaBar = $Meters/mana

onready var portraits = $"Meters/portrait-slot".get_children()
onready var currentIndex = 0
 
func _ready():
	Transition.fade_in()
	currentIndex = global.partyIndex
	update_portrait(currentIndex)
	
func update_gui(player):
	var current = player.currentHealth * 1.0
	var total = player.health * 1.0
	healthbar.value = (current / total) * 100.00 
	
func update_portrait(index):
	if(portraits.size() > 0):
		portraits[currentIndex].visible = false 
		portraits[index].visible = true
		currentIndex = index 