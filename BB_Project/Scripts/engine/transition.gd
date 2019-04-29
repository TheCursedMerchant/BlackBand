extends CanvasLayer

var path = ""

onready var animPlayer = $TextureRect/AnimationPlayer

func fade_to(scn_path):
	self.path = scn_path
	animPlayer.play("fade_in")
	change_scene()
	
func change_scene():
	if(path != ""):
		global.goto_scene(path)
		
func fade_in():
	animPlayer.play("fade_in")
