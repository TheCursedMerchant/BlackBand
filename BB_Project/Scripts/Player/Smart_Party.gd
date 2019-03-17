extends Node

var party = []
var cooldown = 1 
var timer = null
var canSwap = true 
var currentIndex = 0
onready var partyOwner = get_parent()

#Initialize the party
func _ready():	
	#Create party
	party.append(Zulie.new())
	party.append(Astro.new())
	
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
func on_timeout_complete():
	canSwap = true 

func swap(index, forward):
	if(canSwap):
		canSwap = false 
		var newIndex 
		#Check which index to switch too
		if(party.size() >= 2):
			if(forward):
				if(index + 1 < party.size()):
					newIndex = index + 1
				else:
					newIndex = index - 1
			else:
				if(index - 1 >= 0):
					newIndex = index - 1  
				else:
					newIndex = index + 1
					
			currentIndex = newIndex
			owner.anim_player = owner.anim_players.get_child(currentIndex)
			#Add next character to the scene 
			loadCharacterInfo(party[currentIndex])
			global.partyIndex = currentIndex
			owner.anim_player.visible = true
			if(owner.facingDir == dir.right):
				owner.anim_player.flip_h = false
			else:
				owner.anim_player.flip_h = true
			timer.start()
			
func loadCharacterInfo(character):
	owner.partyIndex = character.partyIndex
	owner.health = character.health
	owner.currentHealth = character.currentHealth
	owner.attackType = character.attackType
	owner.gravity = character.gravity
	owner.acceleration = character.acceleration
	owner.maxSpeed = character.maxSpeed
	owner.jumpHeight = character.jumpHeight
	owner.jumpSpeed = character.jumpSpeed
	owner.meleeDamage = character.meleeDamage
	owner.h_meleeKnockback = character.h_meleeKnockback
	owner.v_meleeKnockback = character.v_meleeKnockback
		
		
		
#Character Stat sheets 		
class Zulie:
	var partyIndex = 0
	var health = 5
	var currentHealth = global.zulieHealth
	var attackType = 'ranged'
	var gravity = 10
	var acceleration = 15
	var maxSpeed = 150
	var jumpHeight = 150
	var jumpSpeed = 10
	var meleeDamage = 0
	var h_meleeKnockback = 0
	var v_meleeKnockback = 0
	
class Astro:
	var partyIndex = 1
	var health = 5
	var currentHealth = global.astroHealth
	var attackType = 'melee'
	var gravity = 10
	var acceleration = 20
	var maxSpeed = 240
	var jumpHeight = 250
	var jumpSpeed = 10
	var meleeDamage = 10
	var h_meleeKnockback = 40
	var v_meleeKnockback = -20
	
	
		
		
		

