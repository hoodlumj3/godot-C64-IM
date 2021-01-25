extends Sprite

onready var player = find_parent("Player")


func _ready():
	print(find_parent("Player"))
	print(position)
	
	pass # Replace with function body.

var basetime = 0

func _process(delta):

	if (player.dying):
		print("Player => Sprite => draw => dying")
		basetime += delta
		update()

	pass


func _on_Sprite_draw():
	print("Player => Sprite => draw")
	if (player.dying):
		#print ("get_rect():", get_rect())
		#var v = self.get_viewport().get_visible_rect().size
		#print(v)
		#draw_rect(Rect2(          0,           0,  v.x,         v.y ), Color(randf(),randf(),randf(),1.0), true)
		
		#var texturex = self.texture
		#var bm = BitMap.new()

		#bm.create(Vector2(68,602))
		#bm.create_from_image_alpha(texturex.get_data())
		#var Rectaa = get_rect()
		#var Rectaaa = frame_coords
		#Rectaa.position.y = 32*frame
		#print(Rectaa.size.x, ":", Rectaa.size.y)
		#print(Rectaaa.size.x, ":", Rectaaa.size.y)
		#for x in range(0,Rectaa.size.x):
		#	for y in range(0,Rectaa.size.y):
		#		if (bm.get_bit(Vector2(x,y))):
		#			draw_rect(Rect2(x,y,1,1),Color.red,true) 		
		
		var img = get_viewport().get_texture().get_data()
		img.flip_y()
		var tex = ImageTexture.new()
		tex.create_from_image(img)
		self.texture = tex
		
		print("basetime:", basetime)
		var RectV = get_rect()
		for x in range(0,RectV.size.x):
			for y in range(0,RectV.size.y):
				if ( x < int(basetime*10) ):
					draw_rect(Rect2(x,y,1,1),Color(randf(),randf(),randf(),0.0),true)
		#			draw_rect(Rect2(x,y,1,1),Color.red,true) 		
		
		
		
		pass

