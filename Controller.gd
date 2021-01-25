extends Node2D

signal terminal_access
signal terminal_logoff
signal terminal_disablerobots
signal terminal_resetlifts

# Called when the node enters the scene tree for the first time.
func _ready():
	$RoomTerminal.visible = false
	pass # Replace with function body.

var terminalMessageTimer = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if int(terminalMessageTimer) > 0 :
		terminalMessageTimer -= delta
		print(terminalMessageTimer)
	else:
		if ( int(terminalMessageTimer) == 0 ):
			Global.thisGameState = Global.gamestate.terminal
			terminalMessageTimer = -1
			find_node("RoomTerminal").emit_signal("refresh")
	


func _on_Controller_terminal_access():
	$RoomTerminal.visible = true
	Global.thisGameState = Global.gamestate.terminal
	pass # Replace with function body.


func _on_Controller_terminal_logoff():
	$RoomTerminal.visible = false
	Global.thisGameState = Global.gamestate.room
	pass # Replace with function body.


func _on_Controller_terminal_disablerobots():
	#// 
	#Global.thisRobotState = Global.robotstate.disabled
	#// remember to only count down if gamesate is room
	#Global.thisRobotTimer = 10
	
	terminalMessageTimer = 2.35	
	Global.thisGameState = Global.gamestate.terminalwait
	
	
	pass # Replace with function body.


func _on_Controller_terminal_resetlifts():
	#// reset lifts somehow
	Global.thisGameState = Global.gamestate.terminalwait
	terminalMessageTimer = 2.35
	
	pass # Replace with function body.
