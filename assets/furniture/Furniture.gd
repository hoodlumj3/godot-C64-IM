extends Area2D

export var FunitureName : String = "Blank"  

var playerconnected : bool = false
var timeval = 5

var timervalues = {
	"Bath":5,		
	"Bed":3,		#
	"Bookcase":5,	#
	"ChairLamp":3,	#
	"Computer":-1,	
	"Desk":5,		#
	"Drawers":4,	#
	"Exit":-2,		
	"FirePlace":4,	#
	"Fridge":5,		
	"Kitchenette":5,
	"Lamp":5,		
	"MainFrame":2,	#
	"Piano":1,		#
	"Printer":2,	#
	"Sofa":2,		#
	"Speaker":1,	#
	"Stereo":1.5,		
	"Terminal":1.5,	#
	"Toilet":5,		
	"Vanity":5,		
	"Vending":5,	
	"WaterCooler":5	
}


func _ready():  
	connect("area_entered",self,"_on_Furniture_area_entered")
	connect("area_exited",self,"_on_Furniture_area_exited")
	playerconnected = false
	timeval = timervalues[FunitureName]
	
	collision_layer = 4 #// im on furniture layer
	collision_mask = 0 # notify collide with nobody (raycast2d will handle its own)
	print(name, " tv:", timeval)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _on_Furniture_area_entered(area):
	print("Furniture => ", area.name, " entered ", self.name)
	playerconnected = true
	pass # Replace with function body.


func _on_Furniture_area_exited(area):
	print("Furniture => ", area.name, " exitied ", self.name)
	playerconnected = false
	pass # Replace with function body.

