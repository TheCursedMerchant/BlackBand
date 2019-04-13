extends Area2D

var type = 'SOLID'

func _on_Gate_gateStopped():
	$AnimatedSprite.play('default')


func _on_Pulley_area_entered(area):
	if(area.get('type') == 'fireball'):
		$AnimatedSprite.play('spin')
