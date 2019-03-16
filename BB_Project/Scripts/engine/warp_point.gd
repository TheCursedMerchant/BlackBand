extends Area2D

var global = null

func _ready():
	global = get_node("/root/global")

func _on_WarpPoint_body_entered(body):
	if(body.get('type') == 'PLAYER'):
		global.playerCurrentHealth = body.currentHealth
		global.goto_scene('res://Scenes/Levels/Demo-1-2.tscn')