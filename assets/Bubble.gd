extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var timeval = 99 setget my_var_set, my_var_get
var _timeval = -1
var lasttimeval = -1

func my_var_set(new_value):

	#_searchtimeval = new_value
	timeval = new_value
	#print("new searchtimeval:", new_value)
	#print("intsearchtimeval:",int(timeval/0.25))

	if ( lasttimeval != int(timeval/0.25) && timeval > 0  ):
		update()
		lasttimeval = int(timeval/0.25)

	
func my_var_get():
	return timeval # Getter must return a value.
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#searchtimeval -= delta
	#if (lastsearchtimeval != int(searchtimeval/0.25) ):
	#	#update()
	#	lastsearchtimeval = int(searchtimeval/0.25)
	
	#if ( searchtimeval <= 0 ):
	#	get_parent().visible = false
		
	pass


func _on_Bubble_draw():
	#lh.position = -Vector2((int(position.x) % 16),(int(position.y) % 16))
	#draw_rect(Rect2(Vector2(0,0),Vector2(margin_right-margin_left,margin_bottom-margin_top)),Color(1.0, 1.0, 1.0,1.0),true)
	#draw_rect(Rect2(Vector2(1,1),Vector2(margin_right-margin_left-2,margin_bottom-margin_top-2)),Color(randf(),randf(),randf(),1.0),true)
	
		
		var totalbarsections = rect_size.x / 5
		var barextent = timeval * totalbarsections

		#print ("bartotalwidth:",bartotalwidth, " _searchtimeval:", _searchtimeval, " barwidth:",barwidth, " searchtimeval:",searchtimeval)
		#draw_rect(Rect2(Vector2(0,21),Vector2(barwidth,3)),Color(1.0,0.5,0.0,1.0),true)
		draw_rect(Rect2(Vector2(barextent,21),Vector2(64-barextent,3)),Color(1.0,1.0,1.0,1.0),true)
		#	for a in range(0,margin_right-margin_left+1):
		#		var colr = Color(randf(),randf(),randf(),1.0)
		#		draw_line(Vector2(0,0), Vector2(a,0), colr, 1.0)	



