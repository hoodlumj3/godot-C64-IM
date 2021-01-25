extends Node2D
var size

var rooms_wide = 19  #// every other is a lift shaft 9 room columns 8 lift shafts
var rooms_high = 6
var screen_width = 320/8
var screen_height = 200/8

var rng = RandomNumberGenerator.new()

var room_list = [
	{"id": 0, "joiner":true, "exits":exits.BL+exits.TR, "cell": 9, "col0":"5", "col1":"9","col2":"7", "col3":"15", "rcol0":"1", "rcol1":"14", "rcol2":"14"  },
	{"id": 1, "joiner":true, "exits":exits.BL+exits.TR, "cell": 9  },
	{"id": 2, "joiner":true, "exits":exits.BL+exits.TR, "cell": 9  },
	{"id": 3, "joiner":true, "exits":exits.BL+exits.TR, "cell": 9  },
	{"id": 4, "joiner":true, "exits":exits.TL+exits.BR, "cell": 6  },
	{"id": 5, "joiner":true, "exits":exits.TL+exits.BR, "cell": 6  },
	{"id": 6, "joiner":true, "exits":exits.TL+exits.BR, "cell": 6  },
	{"id": 7, "joiner":true, "exits":exits.TL+exits.BR, "cell": 6  },
	{"id": 8, "joiner":true, "exits":exits.TL+exits.TR, "cell": 7  },
	{"id": 9, "joiner":true, "exits":exits.TL+exits.TR, "cell": 7  },
	{"id":10, "joiner":true, "exits":exits.TL+exits.TR, "cell": 7  },
	{"id":11, "joiner":true, "exits":exits.TL+exits.TR, "cell": 7  },
	{"id":12, "joiner":true, "exits":exits.BL+exits.BR, "cell": 8  },
	{"id":13, "joiner":true, "exits":exits.BL+exits.BR, "cell": 8  },
	{"id":14, "joiner":true, "exits":exits.BL+exits.BR, "cell": 8  },
	{"id":15, "joiner":true, "exits":exits.BL+exits.BR, "cell": 8  },
	{"id":16, "joiner":false, "exits":exits.TR, "cell": 1 },
	{"id":17, "joiner":false, "exits":exits.TR, "cell": 1 },
	{"id":18, "joiner":false, "exits":exits.TR, "cell": 1 },
	{"id":19, "joiner":false, "exits":exits.TR, "cell": 1 },
	{"id":20, "joiner":false, "exits":exits.TL, "cell": 2 },
	{"id":21, "joiner":false, "exits":exits.TL, "cell": 2 },
	{"id":22, "joiner":false, "exits":exits.TL, "cell": 2 },
	{"id":23, "joiner":false, "exits":exits.TL, "cell": 2 },
	{"id":24, "joiner":false, "exits":exits.BR, "cell": 3 },
	{"id":25, "joiner":false, "exits":exits.BR, "cell": 3 },
	{"id":26, "joiner":false, "exits":exits.BR, "cell": 3 },
	{"id":27, "joiner":false, "exits":exits.BR, "cell": 3 },
	{"id":28, "joiner":false, "exits":exits.BL, "cell": 4 },
	{"id":29, "joiner":false, "exits":exits.BL, "cell": 4 },
	{"id":30, "joiner":false, "exits":exits.BL, "cell": 4 },
	{"id":31, "joiner":false, "exits":exits.BL, "cell": 4 }
]



#// TL TR BL BR
enum exits { None=0, TL=1, TR=2, BL=4, BR=8 }

var joiner_rooms : Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]  #// 16 joiner rooms

#var room_exits = [0,exits.TR,exits.TL+exits.BR,exits.TL+exits.TR,exits.BL,exits.BR]

var rooms : Array = []
var roomsVector = []
var roomList = []

func _ready():
	#print("gen rooms")
	randomize()
	_gengen_rooms()
	
	#print(room_list[0])
	
func _gengen_rooms():
	#print ("place 7 of 16 joiner rooms on columns 3,5,7,9,11,13,15 (at varying heights)")
	
	var roomLoopCount = 0
	
	rng.randomize()
	
	
	#//
	#// build a set of room tracking vectors2's 
	#//
	
	roomsVector.clear()
	
	for rx in range(1,rooms_wide,2):
		for ry in range(0,rooms_high):
			roomsVector.push_back(Vector2(rx,ry))
			
		
	#print("roomsVector:",roomsVector.size())
	
	
	#//
	#// null fill rooms array
	#//
	
	rooms.clear()
	
	for rx in rooms_wide:
		var cols = []
		cols.resize(rooms_high)
		rooms.append(cols)
		
	
	roomList = room_list.duplicate()
	
	
	for mixemup in rng.randi_range(0,32):
		roomList.insert(rng.randi_range(0,16),roomList.pop_front())

	#//
	#// plot the joiner rooms - insurance - so we can access the entire set of rooms
	#//
	
	var joinerRoomColumnList = range(3,rooms_wide-2,2)

	joinerRoomColumnList.shuffle()

	for joinerRoomColumn in joinerRoomColumnList:
		
		var joinerRoomRow = rng.randi_range(0,rooms_high-1)
		
		_plot_room(joinerRoomRow,joinerRoomColumn)
		

	#print("roomsVector:",roomsVector.size(),roomsVector)
	
	#print("room:", popRoom, " @(", joinerRoomColumn, ":", joinerRoomRow, ")" )

	if (true):

		roomList.shuffle()
		roomsVector.shuffle()

		#print("roomsVector:",roomsVector.size(),roomsVector)
		#print("roomList:",roomList.size(),roomList)

		#//
		#// plot the first top left room (so we will always have somewhere to start)
		#//
		
		_plot_room(0,1)


		#//
		#// and the last top right room (so the last column isnt left empty)
		#//

		_plot_room(0,17)


		#//
		#// drop in whatever rooms are left
		#//
		
		roomLoopCount = 0
		while(roomList.size() > 0 and roomLoopCount <= 95):
			
			#var roomColumn = roomsVector[0].x
			#var roomRow = roomsVector[0].y
			
			_plot_room(roomsVector[0].y, roomsVector[0].x)

			roomLoopCount += 1


		
	#//
	#// iterate through rooms array and connect the corridors to the shafts
	#//

	#print("create corridors")

	var shaftColumnList = range(2,rooms_wide-1,2)

	for sc in shaftColumnList:	
					
		for sr in range(rooms[sc].size()):
			
			#var shaftCell = rooms[sc][sr]

			
			#var roomLExits = 0
			#var roomRExits = 0
			
			
			#// get roomcell to left -> lookup exits
			#// get roomcell to right -> lookup exits
			#// figure out corridors from left and right room exits connecting them to their common shaft
			
			#print("shaftx: %s @(%s:%s) (%s [%s]:%s [%s]) " % [shaftCell,sc, sr,roomLCell, "room_list[roomLCell]", roomRCell, "room_list[roomRCell]"] )

			var roomExits = 0


			var roomLCell = rooms[sc-1][sr] #// id not array index

			if ( roomLCell != null ):
				#print ( room_list[roomLCell] ) 
				var leftRoomExits = room_list[roomLCell].exits

				if ( leftRoomExits & exits.TR ):
					roomExits |= 1

				if ( leftRoomExits & exits.BR ):
					roomExits |= 4



			var roomRCell = rooms[sc+1][sr] #// id not array index

			if ( roomRCell != null ):
				#print ( room_list[roomRCell] ) 
				var rightRoomExits = room_list[roomRCell].exits
				if ( rightRoomExits & exits.TL ):
					roomExits |= 2

				if ( rightRoomExits & exits.BL ):
					roomExits |= 8
	
				
			rooms[sc][sr] = roomExits + 64
			pass
			
			
	#//	
	#// now translate to minimap
	#//
		
	var minimap = $Console
	#print("RRRR:",rooms.size(),":", rooms[0].size())
	for rc in range(rooms.size()):
		
		for rr in range(rooms[0].size()):
			
			minimap.set_cellv(Vector2(rc,rr),5)	#// clear existing tilemap cell

			var roomCell = rooms[rc][rr]
			if ( roomCell != null ):

				if ( rc % 2 == 1 ):
					var tile = room_list[roomCell].cell
					tile=63
					#print("roomCell[",rc,":",rr,"]:",roomCell, " tile:",tile)
					minimap.set_cellv(Vector2(rc,rr),tile)
				else:
					minimap.set_cellv(Vector2(rc,rr),roomCell)

					
#	var fullMap = $FullMap
#	var corridorLeft = $MapTemplate/Corridor_Left
#	var shaftTop = $MapTemplate/Shaft_Top
#	var shaftBottom = $MapTemplate/Shaft_Bottom
	
	for rc in range(1,rooms.size(),2):		
		for rr in range(rooms[0].size()):
			var roomCell = rooms[rc][rr]
			if( roomCell != null ):
				#print(roomCell, room_list[roomCell])
				_buildandstamp_room(roomCell,rr,rc)
			
	pass

func _buildandstamp_room(_id,_x,_y):
	var fullMap = $FullMap
	
	pass

func _plot_room(_roomRow, _roomColumn):		
		#print ( "roomsVector:", roomsVector )
		var roomIDX = -1
		if ( _roomColumn == 1 ) :
			#print("col1")
			for room in roomList:
				if ( room.exits == exits.TR or room.exits == exits.BR ):
					roomIDX = roomList.find(room)
			#print ( "roomIDX:",roomIDX )
			#pass
		if ( _roomColumn > 1 and _roomColumn < 17 ):
			roomIDX = 0
			#print("col3-15")
			#print ( "roomIDX:",roomIDX )
			#pass
		if ( _roomColumn == 17 ) :
			for room in roomList:
				if ( room.exits == exits.TL or room.exits == exits.BL ):
					roomIDX = roomList.find(room)
			#print("col17")
			#print ( "roomIDX:",roomIDX )
			#pass
		#if ( roomList[roomIDX].exits == exits.TR):
		#	print("TR RL:", roomList[roomIDX] )
		#if ( roomList[roomIDX].exits == exits.BR):
		#	print("BR RL:", roomList[roomIDX] )
		#if ( roomList[roomIDX].exits == exits.TL):
		#	print("TL RL:", roomList[roomIDX] )
		#if ( roomList[roomIDX].exits == exits.BL):
		#	print("BL RL:", roomList[roomIDX] )
		if ( roomIDX >= 0):
			rooms[_roomColumn][_roomRow] = roomList[roomIDX].id
			roomList.remove(roomIDX)
		
		var erase = roomsVector.find(Vector2(_roomColumn,_roomRow))
		#print ("erase:",erase)
		roomsVector.remove(erase)
		



func _process(delta):
	#if ( Input.is_mouse_button_pressed(1)):
	#	_gengen_rooms()
		
	pass
	
func make_room(_pos, _size):
	position = _pos
	size = _size
	var s = RectangleShape2D.new()
	s.extents = size
	
