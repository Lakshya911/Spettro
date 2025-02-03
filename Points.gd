extends Node2D
var x8;
var x9;
var x10;
var n1;
var n2;
var n3;
var n4;
var n5;
var rng = RandomNumberGenerator.new()

# Arrays for spawn positions
var l1 : Array  # Specific objects' positions (AnimatedSprite2D1, 2, 3, Player, DashCursor)
var l : Array    # Rest of the objects' positions

# Reference to sprites and player
var sprites : Array
var player_and_cursor : Array

func _get_calculations():
	x8 = $"../AnimatedSprite2D".global_position
	x9 = $"../AnimatedSprite2D2".global_position
	x10 = $"../AnimatedSprite2D3".global_position
	n1 = $"../AnimatedSprite2D4".global_position
	n2 = $"../AnimatedSprite2D5".global_position
	n3 = $"../AnimatedSprite2D6".global_position
	n4 = $"../AnimatedSprite2D7".global_position
	n5 = $"../AnimatedSprite2D8".global_position

func _ready():
	# Initialize spawn points (l1 and l from your original code)
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

	# Initialize sprites references (all sprites from your original code)
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

	# Place specific objects (sprites 1, 2, 3, Player, DashCursor) at positions from l1
	_place_random_positions_for_l1_objects()

	# Place the rest of the objects (sprites 4-8) at positions from l
	_place_random_positions_for_l_objects()
	
	get_tree().process_frame
	
	_get_calculations()
# Function to place specific objects (sprites 1, 2, 3, Player, DashCursor) at positions from l1
func _place_random_positions_for_l1_objects():
	# Copy l1 to avoid reusing positions
	var l1_positions = l1.duplicate()

	# Place specific sprites (1, 2, 3) at positions from l1
	for i in range(3):  # Index 0, 1, 2 corresponds to sprites 1, 2, 3
		var random_index = rng.randi_range(0, l1_positions.size() - 1)
		var position = l1_positions[random_index]
		l1_positions.erase(random_index)  # Erase the position to avoid reuse
		sprites[i].position = position
		print(sprites[i].name, " placed at ", position)

	# Place Player and DashCursor at positions from l1
	for obj in player_and_cursor:
		var random_index = rng.randi_range(0, l1_positions.size() - 1)
		var position = l1_positions[random_index]
		l1_positions.erase(random_index)  # Erase the position to avoid reuse
		obj.position = position
		print(obj.name, " placed at ", position)

# Function to place remaining objects (sprites 4-8) at positions from l
func _place_random_positions_for_l_objects():
	# Copy l to avoid reusing positions
	var l_positions = l.duplicate()

	# Place the remaining sprites (4, 5, 6, 7, 8) at positions from l
	for i in range(3, sprites.size()):  # Index 3 to 7 corresponds to sprites 4-8
		var random_index = rng.randi_range(0, l_positions.size() - 1)
		var position = l_positions[random_index]
		l_positions.erase(random_index)  # Erase the position to avoid reuse
		sprites[i].position = position
		print(sprites[i].name, " placed at ", position)
