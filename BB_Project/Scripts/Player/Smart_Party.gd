extends Node

var party = []
var currentIndex = 0
onready var partyOwner = get_parent()

#Initialize the party
func _ready():	
	#Create party
	party.append(Zulie.new())
	party.append(Astro.new())
	
func swap(index, forward):
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
			
		#Assign currentIndex to the newIndex 	
		currentIndex = newIndex
		
		#Load character info 
		loadCharacterInfo(party[currentIndex])
		
		#Update partyIndex in global and partyOwner 
		partyOwner.partyIndex = currentIndex
		global.partyIndex = currentIndex
		
		#Update facing direction 
		if(owner.facingDir == dir.right):
			owner.anim_player.flip_h = false
		else:
			owner.anim_player.flip_h = true
			
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
	
	
		
		
		

