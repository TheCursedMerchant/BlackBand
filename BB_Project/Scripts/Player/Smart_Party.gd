extends Node

var party = []
var currentIndex = global.partyIndex
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
		if(partyOwner.facingDir == dir.right):
			partyOwner.anim_player.flip_h = false
		else:
			partyOwner.anim_player.flip_h = true
			
func loadCharacterInfo(character):
	partyOwner.partyIndex = character.partyIndex
	partyOwner.health = character.health
	partyOwner.currentHealth = character.currentHealth
	partyOwner.attackType = character.attackType
	partyOwner.gravity = character.gravity
	partyOwner.acceleration = character.acceleration
	partyOwner.maxSpeed = character.maxSpeed
	partyOwner.jumpHeight = character.jumpHeight
	partyOwner.jumpSpeed = character.jumpSpeed
	partyOwner.meleeDamage = character.meleeDamage
	partyOwner.h_meleeKnockback = character.h_meleeKnockback
	partyOwner.v_meleeKnockback = character.v_meleeKnockback
	partyOwner.jumpMoveModifier = character.jumpMoveModifier
		
		
#Character Stat sheets 		
class Zulie:
	var partyIndex = 0
	var health = 5
	var currentHealth = global.zulieHealth
	var attackType = 'ranged'
	var gravity = 10
	var acceleration = 15
	var maxSpeed = 150
	var jumpHeight = 120
	var jumpSpeed = 20
	var meleeDamage = 0
	var h_meleeKnockback = 0
	var v_meleeKnockback = 0
	var jumpMoveModifier = 2
	
class Astro:
	var partyIndex = 1
	var health = 5
	var currentHealth = global.astroHealth
	var attackType = 'melee'
	var gravity = 10
	var acceleration = 20
	var maxSpeed = 180
	var jumpHeight = 210
	var jumpSpeed = 40
	var meleeDamage = 10
	var h_meleeKnockback = 40
	var v_meleeKnockback = -20
	var jumpMoveModifier = 3
	
		
		
		

