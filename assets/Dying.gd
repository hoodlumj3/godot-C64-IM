tool
extends Sprite

onready var player = find_parent("Player")
var imageMask
var imageA
var textureA
var basetime = 0

func _ready():
	#print(find_parent("Player"))
	#print(position)
	self.visible = false
	pass # Replace with function body.

func execute():
	basetime = 0
#	var img = find_parent("Player").get_node("Flip/Sprite").get_viewport().get_texture().get_data()
#	#img.flip_y()
#	var tex = ImageTexture.new()
#	tex.create_from_image(img)

#	self.texture = tex
	
	
#	var a = self.texture.get_data()
#	var b
#	print(a)
#	b=a.crop(16,16)
#	print(b)
	var nodetocopy = find_parent("Player").get_node("Flip/Sprite")
	var nodefc = nodetocopy.frame_coords
	var nodeTexture = nodetocopy.texture
	var nodeImage = nodeTexture.get_data()
	textureA = ImageTexture.new()
	
	
	#var img=Image.new()
	#img.lock()
	#img.create(32,32,false,Image.FORMAT_RGB8)
	##img.blit_rect(load("res://icon.png"),img.get_used_rect(),Vector2(40,40))
	#img.unlock()
	#a.blit_rect(a,)
	#texture.
	
	#a.blit_rect(texture.get_data().ima)
	#nodeImage.crop(32,32)
	
	print(nodefc)
	
	#textureA.create_from_image(nodeImage,Texture.FLAG_VIDEO_SURFACE)  # //.FLAG_CONVERT_TO_LINEAR

	#var nwImage = textureA.get_data()
	
	#var textureX = ImageTexture.new()
	#var imageX = Image.new()
	#imageX.lock()
	#imageX.create(32,32,false,Image.FORMAT_RGBA8)
	#imageX.blit_rect(nodeImage,Rect2(Vector2(nodefc.x*32,nodefc.y*32),Vector2(32,32)),Vector2(0,0))
	#imageX.blit_rect(nodeImage,Rect2(Vector2(0,32),Vector2(32,32)),Vector2(0,0))
	
	#imageX.unlock()
	
	#textureX.create_from_image( imageX )
	
	#print(Rect2(Vector2(nodefc.x*32,nodefc.y*32),Vector2(32,32)))
	#print( "nodeImage.get_used_rect():", nodeImage.get_used_rect())

	
	imageMask = Image.new()
	imageMask.create(32,32,false,Image.FORMAT_RGBA8)

	imageA = nodeTexture.get_data()
	
#	
#	void blit_rect_mask(src: Image, mask: Image, src_rect: Rect2, dst: Vector2)
#		Blits src_rect area from src image to this image at the coordinates given by dst. 
#		src pixel is copied onto dst if the corresponding mask pixel's alpha value is not 0. 
#		src image and mask image must have the same size (width and height) but they can have different formats.
#
#
	imageMask.lock()
	for y in range(0,31):
		for x in range(0,31):	
			if ( x%2 ):
				imageMask.set_pixelv(Vector2(x,y),Color.red)
			
	imageMask.unlock()
	
	imageA.blit_rect(nodeImage,Rect2(Vector2(nodefc.x*32,nodefc.y*32),Vector2(32,32)),Vector2(0,0))
	imageA.crop(32,32)

	textureA.create_from_image(imageA,Texture.FLAG_VIDEO_SURFACE)  # //.FLAG_CONVERT_TO_LINEAR
	
	
	
	var imageB = Image.new()
	imageB.create(32,32,false,Image.FORMAT_RGBA8)
	
	imageB.blit_rect_mask(imageA, imageMask, Rect2(Vector2(0,0),Vector2(32,32)),Vector2(0,0))

	textureA.create_from_image(imageB,Texture.FLAG_VIDEO_SURFACE)  # //.FLAG_CONVERT_TO_LINEAR
	
	#texture.create_from_image(nwImage,Texture.FLAG_VIDEO_SURFACE)  # //.FLAG_CONVERT_TO_LINEAR

#void blit_rect(src: Image, src_rect: Rect2, dst: Vector2)

#Copies src_rect from src image to this image at coordinates dst.
	
	
	#texture.create_from_image(a,Texture.FLAG_CONVERT_TO_LINEAR)
	
	self.texture = textureA
	
	pixelarray.clear()
	for pa in range(0,32*32):
		pixelarray.append(pa)
	
	#print(pixelarray)
	
	self.visible = true


func _process(delta):

	if (self.visible):
#		print("Player => Sprite => draw => dying")
		basetime += delta
		var x = randf()
		modulate = Color(x,x,x,1.0)
		update()
	pass


var _basetime = -1	
var pixelarray = []

func _on_Dying_draw():
	if ( self.visible ):
		#print("Player => Sprite => draw")
		var _tbasetime = basetime * 1
		if ( _basetime != int(_tbasetime) ):
			print("basetime:", int(_tbasetime))
			
		if ( true ):
			var counter = 0
			imageMask.create(32,32,false,Image.FORMAT_RGBA8)

			imageMask.lock()
			
			if ( pixelarray.size() ):
				if ( pixelarray.size() ): pixelarray.remove(randi()%pixelarray.size())
				if ( pixelarray.size() ): pixelarray.remove(randi()%pixelarray.size())
				if ( pixelarray.size() ): pixelarray.remove(randi()%pixelarray.size())
				#if ( pixelarray.size() ): pixelarray.remove(randi()%pixelarray.size())
				
				for pa in range(0,pixelarray.size()):
					var va = pixelarray[pa]
					var x = va % 32
					var y = int(va / 32)
					#if ( pixelarray[pa] != -1 ):
					imageMask.set_pixelv(Vector2(x,y),Color.red)
			else:
				find_parent("Player").emit_signal("player_vaporised")
				visible = false
				
			if ( false) :
				var modbythis = (32*32)/64
				
							
				for y in range(0,31):
					for x in range(0,31):
						if ( int(_tbasetime)%modbythis == 0 ):
							imageMask.set_pixelv(Vector2(x,y),Color.red)
						counter += 1
						
			imageMask.unlock()
			
			var imageB = Image.new()
			
			imageB.create(32,32,false,Image.FORMAT_RGBA8)
		
			imageB.blit_rect_mask(imageA, imageMask, Rect2(Vector2(0,0),Vector2(32,32)),Vector2(0,0))

			textureA.create_from_image(imageB,Texture.FLAG_VIDEO_SURFACE)  # //.FLAG_CONVERT_TO_LINEAR
			_basetime = int(_tbasetime)
	pass
	
func xyz():
	if (false):
		
		#var vp = get_node(".").get_viewport()
		#var texture = vp.get_texture()
		#var image = texture.get_data()
		#image.lock()
		#image.set_pixel(0,0,Color.red)
		#$Control/Credit.draw_rect(Rect2(0,0,120,10),Color.red,true)	
		#image.unlock()
		
		return
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
	
	if ( false ):
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





func _on_Dying_visibility_changed():
	if ( visible == true ):
		execute()
	pass # Replace with function body.
