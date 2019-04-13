extends CollisionShape2D

export var margin : float = 1.0

func _ready():
	set_one_way_collision_margin(margin)
