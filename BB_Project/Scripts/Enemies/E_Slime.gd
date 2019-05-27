extends "../engine/entity.gd"

onready var anim_player = $Anim_Player
onready var floor_checker = $floor_checker

#State variables
onready var grounded = is_grounded()
export var attackRange = 15
export var exhaustTime = .5
export var resistance = 100

var chaseTarget = null

onready var stateManager = $States

#Initialize Slime Enemy 
func _ready():
	#Set my camera 
	if(facingDir == dir.right):
		floor_checker.position.x = maxSpeed/2
	else:
		floor_checker.position.x = -maxSpeed/2
	camera = get_node('../MainCamera')
	currentHealth = health
	type = 'ENEMY'
	
#Defer physics process to our state
func _physics_process(delta):
	is_grounded()
	anim_player.play(stateManager.currentState.get_name())
	
#Check if enemy is on the ground 
func is_grounded():
	if($ground_ray.is_colliding()):
		grounded = true
	else:
		grounded = false
		
#Check if there is ground where the enemy is going to move to
func check_ground():
	if(floor_checker.is_colliding()):
		return true
	else:
		return false 
		