extends Area2D


#signal player_searching_start
#signal player_searching_stop
#signal player_searching
#signal player_run_left
#signal player_run_right
#signal player_run_jump
#signal player_stand

signal player_die
signal player_vaporised
signal player_fallen

var dying = false

enum pstate {gostand, goleft, goright, gojump, gosearch}

var this_state = pstate.gostand

var playerinfrontoffurniture = null
#var playersearchstartsignal : bool = false

var searchtimeval = 0
var _searchtimeval
var lastsearchtimeval

var movedir : Vector2 = Vector2(0,0)
var lastmovedir : Vector2 = Vector2(0,0)

var last_posx = 0



func _ready():
	
	playerinfrontoffurniture = null

	$Searching.visible = false
	$Flip/Dying.visible = false
	
	pass


func _input(event):
	#print("event:",event)	
	pass

func _process(delta):

	if ( Global.thisGameState != Global.gamestate.room and Global.thisGameState != Global.gamestate.corridor  ):
		return

	if Global.gameProcessing == false: 
		return

#	global_position = get_global_mouse_position()

	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN) 
	
	#if ( movedir.x != 0  ):
	#	movedir.y = 0
	#	pass
	#print("movedir:", movedir)
	
	if ( movedir != lastmovedir ):
		
		if lastmovedir.x !=0 :
			movedir.y = 0

		if lastmovedir.y !=0 :
			movedir.x = 0
		
		lastmovedir = movedir
		pass
	
	
	if ( movedir.x < 0 ): #and this_state != pstate.gosearch ):
		#emit_signal("player_run_left")
		enter_state(pstate.goleft)
			
		
	if ( movedir.x > 0 ): #and this_state != pstate.gosearch):
		#emit_signal("player_run_right")
		enter_state(pstate.goright)
	
	
	if ( movedir.x == 0 and movedir.y == 0):
		#emit_signal("player_stand")
		enter_state(pstate.gostand)
	
	if ( Input.is_action_pressed("ui_select") ):
		#emit_signal("player_run_jump")
		enter_state(pstate.gojump)
		
	if ( movedir.y < 0 and movedir.x == 0):	#// up and not moving
		#print("isCollidoing:", $Flip/InFrontOf.is_colliding(), ":", $Flip/InFrontOf.get_collider())
		playerinfrontoffurniture = $Flip/StandingInFrontOf.get_collider()
		if ( playerinfrontoffurniture != null ):
			
			enter_state(pstate.gosearch)

	#else:  #// not up (default state - not release but yes release)
	#	
	#	if ( (this_state==pstate.gosearch) == true ):
	#		#playersearchstartsignal = false
	#		_on_Player_player_searching_stop()
	#		#emit_signal("player_searching_stop")
	#	pass
		
		
	if ( movedir.y > 0 ):	#// down
		pass
		
		
	if ( Input.is_mouse_button_pressed(1) == true and 1 == 0):
		pass
		

	
		#playersearchstartsignal
	

	process_states(delta)
	
	
	pass


func _on_Player_area_entered(area):
	#print(area.name, " entered ", area.collision_layer)
	if ( area.collision_layer == 4 ):
		
		playerinfrontoffurniture = area
		
	pass # Replace with function body.


func _on_Player_area_exited(area):
	#print(area.name, " exited ", area.collision_layer)
	if ( area.collision_layer == 4 ):
		if ( area == playerinfrontoffurniture ):
			playerinfrontoffurniture = null
	pass # Replace with function body.



 
var last_state = 999






















	
	
	
func enter_state(_state):
	if ( _state != this_state ) :
		print("new state : ", _state)
		leave_state(this_state)
		this_state = _state		
		
		if ( this_state == pstate.goleft ):
			$Flip/Sprite.frame = 8
			$Flip.scale.x=1.0
			last_posx = global_position.x
			this_pos = global_position.x

			pass
		elif ( this_state == pstate.goright ):
			$Flip/Sprite.frame = 8
			$Flip.scale.x=-1.0
			last_posx = global_position.x
			this_pos = global_position.x

			pass
		elif ( this_state == pstate.gostand ):
			
			if ( ( last_state == pstate.goleft or last_state == pstate.goright )  and (last_posx - global_position.x) == 0 ):
				
				global_position.x += (4*-$Flip.scale.x)
				
				#print("pstate.gostand:", (last_posx - global_position.x), "::" )
			
			$Flip/Sprite.frame = 0
			$Flip/StandingInFrontOf.enabled = true;



		elif ( this_state == pstate.gosearch ):

			print("gosearch:","here")

			_on_Player_searching_start()
					
			pass

		last_state = this_state

	pass




var this_pos = 0
var last_frame = 999



func process_states(_delta):
	var currposx = 0 
	var xframe = 0
	var currposx2 = 0
	var this_posx = 0
	var framex2 = 0
	
	if ( this_state == pstate.goleft or this_state == pstate.goright):
		this_pos += movedir.x * _delta * 50  # 50
		currposx2 = ((this_pos - last_posx)/4) 
		this_posx = abs(int(this_pos+currposx2))
		
		framex2 = int(abs(currposx2))%14
		$Flip/Sprite.frame = ((1+framex2)*8)
		if ( last_frame != framex2 ):
			#print("this_pos:",this_pos, " last_posx:", last_posx, " GPx:", global_position.x, " _delta:", _delta, " currposx2:", currposx2, " framex2:",framex2, " D:", (global_position.x - this_posx) )

			global_position.x = this_posx
			
			last_frame = framex2



	elif ( this_state == pstate.gostand):
		
		pass
		
		
		
	elif ( this_state == pstate.gosearch ):
		
		searchtimeval -= _delta
		_on_Player_searching()
		
	
	pass
	



		
func leave_state(_state):
	
	
	if ( _state == pstate.gostand):
		$Flip/StandingInFrontOf.enabled = false
		
		
	elif (_state == pstate.gosearch):

		_on_Player_searching_stop()
		
		
	pass
	














func _on_Player_searching_start():
	#print("Signal recieved _on_Player_Searching_Start")	
	
	
	print(playerinfrontoffurniture.name, ":", playerinfrontoffurniture.FunitureName)

	$Flip/Sprite.frame = 128

	if ( playerinfrontoffurniture.FunitureName == "Terminal" ):
		#// robot sound off
		#// hide room
		#// show terminal 
		#// 	controls over to terminal
		
		find_parent("Controller").emit_signal("terminal_access")
		
		return

	searchtimeval = playerinfrontoffurniture.timeval
	_searchtimeval = searchtimeval
	lastsearchtimeval = -1


	#$Flip/AnimatedSprite.play("search")
	$Searching/Bubble._timeval = searchtimeval
	$Searching/Bubble.timeval = searchtimeval
	$Searching.position = Vector2(16,-48)
	$Searching/Sprite.frame = 3
	$Searching/Bubble.visible = true
	$Searching.visible=true


func _on_Player_searching():
	#print("Signal recieved _on_Player_Searching")	
	$Searching/Bubble.timeval = searchtimeval
	playerinfrontoffurniture.timeval = searchtimeval
	if ( searchtimeval <= 0 ):
		$Searching/Bubble.visible = false
		$Searching/Sprite.frame = 2



func _on_Player_searching_stop():
	if ( playerinfrontoffurniture.FunitureName == "Terminal" ):
		return
	
	#print("Signal recieved _on_Player_Searching_Stop")	
	#$Flip/AnimatedSprite.play("stand")
	$Searching.visible=false
	if playerinfrontoffurniture != null and searchtimeval <= 0 :
		playerinfrontoffurniture.visible = false
		playerinfrontoffurniture.get_node("CollisionShape2D").disabled = true
		










#func _on_Area2D_area_entered(area):
#	pass # Replace with function body.


func _on_Player_body_entered(body):
	print("Player => ", body.name, " entered ", body.collision_layer)
	pass # Replace with function body.


func _on_Player_body_exited(body):
	print("Player => ", body.name, " exited ", body.collision_layer)
	pass # Replace with function body.


func _on_Player_player_die():
	print("signal Player => Die")
	
	#// halt everything 
	Global.gameProcessing = false
	Global.playerControl = false
	dying = true
	$Flip/Sprite.visible = false
	$Flip/Dying.execute()
	
	#// animate player dying
	#// add 10 mins to clock
	
	pass # Replace with function body.


func _on_Player_player_vaporised():
	dying = false
	Global.gameProcessing = true
	$Flip/Dying.visible = false
	$Flip/Sprite.visible = true
	pass # Replace with function body.
