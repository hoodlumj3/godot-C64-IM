extends Node
class_name aRoom

var id:int
var joiner:bool
var exits:int

var x:int
var y:int

func _init( _id, _joiner, _exits ):
	print("new myroom id:", _id, " joinerroom:", _joiner)

	self.id = _id
	self.joiner = _joiner
	self.exits = _exits
	
	pass
