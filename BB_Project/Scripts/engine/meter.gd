extends Sprite

#Script assumes the object attatched to it is a rectangle 
export var percentage = .2

onready var ratio = Vector2(0.05, 1)

func _ready():
	set_process(true)
	
func _process():
	scale = ratio
