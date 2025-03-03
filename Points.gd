extends Node2D

var x8
var x9
var x10
var n1
var n2
var n3
var n4
var n5
var rng = RandomNumberGenerator.new()

# Arrays for spawn positions
var l1 : Array  # Special positions for specific objects
var l : Array   # Positions for other objects

# Reference to sprites and player
var sprites : Array
var player_and_cursor : Array

func get_calculations():
	x8 = $"../AnimatedSprite2D".global_position
	x9 = $"../AnimatedSprite2D2".global_position
	x10 = $"../AnimatedSprite2D3".global_position
	n1 = $"../AnimatedSprite2D4".global_position
	n2 = $"../AnimatedSprite2D5".global_position
	n3 = $"../AnimatedSprite2D6".global_position
	n4 = $"../AnimatedSprite2D7".global_position
	n5 = $"../AnimatedSprite2D8".global_position
	print("Positions calculated:")
	print("AnimatedSprite2D: ", x8)
	print("AnimatedSprite2D2: ", x9)
	print("AnimatedSprite2D3: ", x10)

func _ready():
	rng.randomize()
	
	# Initialize spawn points
	l1 = [
		$Node2D6/Marker2D.global_position,
		$Node2D7/Marker2D.global_position,
		$Node2D12/Marker2D.global_position,
		$Node2D13/Marker2D.global_position,
		$Node2D18/Marker2D.global_position
	]
	
	l = [
		$Node2D4/Marker2D.global_position,
		$Node2D5/Marker2D.global_position,
		$Node2D10/Marker2D.global_position,
		$Node2D11/Marker2D.global_position,
		$Node2D15/Marker2D.global_position,
		$Node2D16/Marker2D.global_position,
		$Node2D17/Marker2D.global_position,
		$Node2D14/Marker2D.global_position,
		$Node2D19/Marker2D.global_position,
		$Node2D8/Marker2D.global_position,
		$Node2D9/Marker2D.global_position
	]
	
	# Initialize sprites references
	sprites = [
		$"../AnimatedSprite2D", 
		$"../AnimatedSprite2D2", 
		$"../AnimatedSprite2D3", 
		$"../AnimatedSprite2D4", 
		$"../AnimatedSprite2D5", 
		$"../AnimatedSprite2D6", 
		$"../AnimatedSprite2D7", 
		$"../AnimatedSprite2D8"
	]
	
	# Player and DashCursor references
	player_and_cursor = [
		$"../Player", 
		$"../Player/DashCursor"
	]
	
	# Place objects properly based on the specific requirements
	place_objects_correctly()
	
	# Run calculations immediately
	get_calculations()
	
	# Set up physics process for continuous updates
	set_physics_process(true)

func _physics_process(_delta):
	# Update calculations every frame
	get_calculations()

func place_objects_correctly():
	# Shuffle the l1 positions list
	var l1_positions = l1.duplicate()
	l1_positions.shuffle()
	
	# Shuffle the l positions list
	var l_positions = l.duplicate()
	l_positions.shuffle()
	
	# Place the first 3 sprites at positions from l1
	for i in range(3):
		if l1_positions.size() > 0:
			var pos = l1_positions.pop_front()
			sprites[i].global_position = pos
			print("Placed " + sprites[i].name + " at position from l1: " + str(pos))
	
	# Place Player and DashCursor at THE SAME position from l1
	if l1_positions.size() > 0:
		var pos = l1_positions.pop_front()
		player_and_cursor[0].global_position = pos  # Player
		player_and_cursor[1].global_position = pos  # DashCursor
		print("Placed Player and DashCursor at the same position from l1: " + str(pos))
	
	# Place remaining sprites (4-8) at positions from l
	for i in range(3, sprites.size()):
		if l_positions.size() > 0:
			var pos = l_positions.pop_front()
			sprites[i].global_position = pos
			print("Placed " + sprites[i].name + " at position from l: " + str(pos))
