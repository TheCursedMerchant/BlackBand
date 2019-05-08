#Script controls how the knife gui is displayed 
extends Node2D

#Reference to each knife node 
onready var knifeNodes = get_children()

#Constant Members 
const ON = "on"
const OFF = "off"

var currentDirection = Vector2(0, 0)

#Handle knife point highlight logic 
func switchNode():
	if(knifeNodes.size() == 8):
		match currentDirection:
			Vector2(0, 0):
				selectNode(null)
			dir.up:
				selectNode(knifeNodes[0])
			dir.down:
				selectNode(knifeNodes[1])
			dir.left:
				selectNode(knifeNodes[2])
			dir.right:
				selectNode(knifeNodes[3])
			dir.u_left:
				selectNode(knifeNodes[4])
			dir.d_left:
				selectNode(knifeNodes[5])
			dir.u_right:
				selectNode(knifeNodes[6])
			dir.d_right:
				selectNode(knifeNodes[7])
	
#Iterate through nodes to select it 
#Passing Null will turn off all nodes 
func selectNode(selectedNode):
	for node in knifeNodes:
		if(node != selectedNode):
			node.play(OFF)
		else:
			node.play(ON)
	  
