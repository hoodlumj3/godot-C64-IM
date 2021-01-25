extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var player = get_node("../Player")
	$movex.text = "MoveX:("+String(player.position.x)+")" + String(player.movedir.x)
	$movey.text = "MoveX:("+String(player.position.y)+")" + String(player.movedir.y)
	
	#$Overlay/movex
	
	var ifo = player.playerinfrontoffurniture
	if ( ifo != null ):
		$InFrontOf.text = "InFrontOf:" + ifo.name
	else:
		$InFrontOf.text = "InFrontOf: null"
	
	var pstate = player.this_state
	$pState.text = "pState:" + String(pstate)
	#	$"Room 01/Actors/Player".movedir
	pass
