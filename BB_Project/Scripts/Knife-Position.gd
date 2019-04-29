extends Position2D

#Reference to knife 
onready var knife_scene = preload("res://Scenes/Player Objects/Knife.tscn")

var currentKnife

func spawnKnife():
	var knife = knife_scene.instance(0)
	currentKnife = knife
	get_tree().get_root().add_child(knife)
	knife.position = position
	knife.followTarget = self
	
func despawnKnife():
	currentKnife.queue_free()
