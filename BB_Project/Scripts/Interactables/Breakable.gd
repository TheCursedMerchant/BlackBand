extends Area2D

#Custom Properties
export var dropRate : float = 1.0
#export var itemDrop

#Static Properties 
var type = 'BREAKABLE'

#Child References 
onready var animPlayer = $AnimPlayer

#Destroy method potentially drop item 
func destroy():
	animPlayer.play('break')
	drop()
	
func _on_AnimPlayer_animation_finished():
	if(animPlayer.animation == 'break'):
		queue_free()

#TODO: Add item to be dropped 
func drop():
	pass