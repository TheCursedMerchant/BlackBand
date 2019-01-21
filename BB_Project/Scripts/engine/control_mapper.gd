extends Node

var UP
var DOWN 
var LEFT 
var RIGHT 
var ATTACK

func getInput():
	UP = Input.is_action_pressed("ui_up")
	DOWN = Input.is_action_pressed("ui_down")
	LEFT = Input.is_action_pressed("ui_left")
	RIGHT = Input.is_action_pressed("ui_right")
	ATTACK = Input.is_action_pressed("ui_accept")


