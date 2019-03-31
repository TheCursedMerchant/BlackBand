extends Area2D

var type = 'FIRE_SWITCH'

func _on_Gate_gateStopped():
	$AnimatedSprite.play('default')

func _on_Pulley_area_entered(area):
	print(area.get("type"))
	if(area.get('type') == 'fireball'):
		$AnimatedSprite.play('spin')
