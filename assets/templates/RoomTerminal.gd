extends TileMap

signal refresh

var posposy = [7,10,17]
var selection = 2
var _selection = -1
var movedir = Vector2(0,0)
var _movedir = Vector2(0,0)

var refreshspeed = 30
var screendrawing = 0


func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#if ( timer > 0 ) : timer -= delta
	#print(timer)
	if ( !visible and Global.thisGameState != Global.gamestate.terminal ):
		return
	
	#print ( _movedir, ":", movedir )

	if ( int(screendrawing) < 15 ):

		#// draw terminal text slowly

		screendrawing += delta*refreshspeed
		
		for y in range (3,3+int(screendrawing)):
			for x in range (10,40):
				var getcell = $Text.get_cellv(Vector2(x,y+25))
				#getcell = 33
				$Text.set_cellv(Vector2(x,y),getcell)
		
		
		print("screendrawing:",screendrawing)
	else:

		var LEFT = Input.is_action_pressed("ui_left")	
		var RIGHT = Input.is_action_pressed("ui_right")
		var UP = Input.is_action_pressed("ui_up")
		var DOWN = Input.is_action_pressed("ui_down")
		var SELECT = Input.is_action_pressed("ui_accept")
		
		movedir.x = -int(LEFT) + int(RIGHT)
		movedir.y = -int(UP) + int(DOWN) 

	
		if movedir.y == -1 and _movedir.y != movedir.y:
			if selection > 0: selection -= 1
		
		if movedir.y == 1 and _movedir.y != movedir.y:
			if selection < 2: selection += 1
		
	
		if ( _movedir.y != movedir.y ):
			_movedir.y = movedir.y

		if ( SELECT ) :
			if selection == 2 :
				find_parent("Controller").emit_signal("terminal_logoff")
			elif selection == 1:
				
				for y in range (0,3):
					for x in range (10,40):
						var getcell = $Text.get_cellv(Vector2(x,y+51))
						#getcell = 33
						$Text.set_cellv(Vector2(x,y+10),getcell)
				
				find_parent("Controller").emit_signal("terminal_disablerobots")
				
			elif selection == 0:
				
				for y in range (0,3):
					for x in range (10,40):
						var getcell = $Text.get_cellv(Vector2(x,y+51))
						#getcell = 33
						$Text.set_cellv(Vector2(x,y+7),getcell)
				
				find_parent("Controller").emit_signal("terminal_resetlifts")
	
		if ( selection != _selection ):
		
			#//
			#// clear existing selection
			#//
			for y in range (7,18):
				
				for x in range (6,9):
					
					$Text.set_cell(x, y, -1)

			
			for x in range (6,9):

				var getcell = $Text.get_cellv(Vector2(x-6,50))

				$Text.set_cellv(Vector2(x,posposy[selection]),getcell)
		
			_selection = selection

			print("pos:", selection)	




func _on_RoomTerminal_visibility_changed():
	
	
	print( "_on_RoomTerminal_visibility_changed to ", visible )

	if (visible):

		#//
		#// move tilemap onto screen 
		#// find what room this is
		#// restore screen text 40x25
		#// update the terminal number on the text tilemap
		#// set shader colours (correlation to what though?)
		#// set selection to "log off"
		#//
	
		position.y = 0
		
		for y in range (0,25):
			for x in range (0,40):
				$Text.set_cellv(Vector2(x,y),-1)
	
		
		
		selection = 2
		_selection = -1
		screendrawing = 0
		refreshspeed = 30
		
	else:
		#//
		#// move tilemap off screen
		#//
		position.y = 240
		pass # Replace with function body.
		


func _on_RoomTerminal_refresh():
	screendrawing = 0
	refreshspeed = 1000
	_selection = -1
	pass # Replace with function body.
