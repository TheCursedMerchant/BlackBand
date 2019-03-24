extends Area2D

var global = null
export var nextLocation = 'door'
export var scene = 'res://Scenes/Levels/Demo-1-2BAD.tscn'

func _ready():
	global = get_node("/root/global")

func _on_WarpPoint_body_entered(body):
	if(body.get('type') == 'PLAYER'):
		global.playerCurrentHealth = body.currentHealth
		global.playerCurrentFacingDir = body.facingDir
		global.spawnLocation = nextLocation
		global.goto_scene(scene)
