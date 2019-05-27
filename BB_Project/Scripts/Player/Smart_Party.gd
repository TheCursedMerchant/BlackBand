extends Node

var party = []
var currentIndex = global.partyIndex
onready var partyOwner = get_parent()

#Initialize the party
func _ready():	
	#Create party
	party.append(Zulie.new())
	party.append(Astro.new())

#Handle Swap logic 
func swap(index, forward):
	#Check which index to switch too
	if(party.size() >= 2):
		if(forward):
			if(index + 1 < party.size()):
				currentIndex = index + 1
			else:
				currentIndex = index - 1
		else:
			if(index - 1 >= 0):
				currentIndex = index - 1  
			else:
				currentIndex = index + 1 		
					
		#Load character info 
		loadCharacterInfo(party[currentIndex])
		
		#Update partyIndex in global and partyOwner 
		partyOwner.partyIndex = currentIndex
		global.partyIndex = currentIndex
		global.currentCharacter = partyOwner.currentCharacter
		
		#Handle post character load info 
		updateCharacter()

#Load character attributes to player 
func loadCharacterInfo(character):
	partyOwner.currentCharacter = character.characterName
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

func updateCharacter():
	#Update facing direction 
	if(partyOwner.facingDir == dir.right):
		partyOwner.anim_player.flip_h = false
	else:
		partyOwner.anim_player.flip_h = true
	if(partyOwner.currentCharacter == 'Astro'):
		partyOwner.knifePosition.spawnKnife()
		#partyOwner.createKnifeRay()
	else:
		if(partyOwner.knifePosition.currentKnife != null):
			partyOwner.knifePosition.despawnKnife()
		#if(partyOwner.knifeRay != null):
			#partyOwner.knifeRay.queue_free()
			
#Character Stat sheets 		
class Zulie:
	var characterName = "Zulie"
	var partyIndex = 0
	var health = 100
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
	var characterName = 'Astro'
	var partyIndex = 1
	var health = 100
	var currentHealth = global.astroHealth
	var attackType = 'melee'
	var gravity = 10
	var acceleration = 25
	var maxSpeed = 180
	var jumpHeight = 240
	var jumpSpeed = 60
	var meleeDamage = 50
	var h_meleeKnockback = 40
	var v_meleeKnockback = -20
	var jumpMoveModifier = 3
	
		
		
		

