extends KinematicBody2D

export var direction = Vector2(0, 0)  
export var hSpeed = 10 
export var vSpeed = 10
export var active = true
export var maxDistance = 100  

var startLoc
var motion = Vector2(0, 0)

func _ready():
	startLoc = global_position

func _physics_process(delta):
	if(active):
		motion.x = hSpeed
		motion.y = vSpeed 
		move_and_slide(motion * direction, dir.up) 
	if(global_position.distance_to(startLoc) >= maxDistance):
		startLoc = global_position
		direction *= -1
