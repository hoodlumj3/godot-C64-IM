extends Node

var gameProcessing = false
var playerControl = false

const ROOMCOUNT = 32
const FURNITURECOUNT = 128
const PUZZLEPEICECOUNT = 64


var ROOMS = []

# // fill this with furniture ids, these will match up with puzzle peices
var FURNITURE = []  

# // there will be x puzzlepeices - each one of these will be attached to a 
# // bit of furniture
var PUZZLEPEICES = []  

# // the puzzle to furniture index 
var PUZZLE_FURNITURE = []

# // the furniture index and which room its in 
# // as rooms are entered this array gets filled
var FURNITURE_ROOM = []

func _shuffleArray(_array):
	var shuffledList = []
	var indexList = range(PUZZLEPEICES.size())
	for i in range(PUZZLEPEICES.size()):
		var x = randi() % indexList.size()
		shuffledList.append(PUZZLEPEICES[indexList[x]])
		indexList.remove(x)
		
	return shuffledList

func _ready():
	print ("Global Loaded")
	
	for peice in range(1,ROOMCOUNT):
		
		PUZZLEPEICES.append(peice)
		
		FURNITURE.append(peice)
		
	PUZZLEPEICES = _shuffleArray(PUZZLEPEICES)
	
	print (PUZZLEPEICES)
	
	gameProcessing = true
	playerControl = true
	
	pass
