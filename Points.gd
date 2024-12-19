extends Node2D
var x = RandomNumberGenerator.new()
var y;
var o;
var o1 = 0
var x8;
var x9;
var x10;
var n1;
var n2;
var n3;
var n4;
var n5;
var nkcn : Vector2;
func _get_calculations():
	x8 = $"../AnimatedSprite2D".global_position
	x9 = $"../AnimatedSprite2D2".global_position
	x10 = $"../AnimatedSprite2D3".global_position
	n1 = $"../Node2D3/AnimatedSprite2D4".global_position
	n2 = $"../Node2D3/AnimatedSprite2D5".global_position
	n3 = $"../Node2D3/AnimatedSprite2D6".global_position
	n4 = $"../Node2D3/AnimatedSprite2D7".global_position
	n5 = $"../Node2D3/AnimatedSprite2D8".global_position
func _ready():
	var p1 = $Node2D4/Marker2D.global_position
	var p2 = $Node2D5/Marker2D.global_position
	var p3 = $Node2D6/Marker2D.global_position
	var p4 = $Node2D7/Marker2D.global_position
	var p5 = $Node2D8/Marker2D.global_position
	var p6 = $Node2D9/Marker2D.global_position
	var p7 = $Node2D10/Marker2D.global_position
	var p8 = $Node2D11/Marker2D.global_position
	var p9 = $Node2D12/Marker2D.global_position
	var p10 = $Node2D13/Marker2D.global_position
	var p11 = $Node2D14/Marker2D.global_position
	var p12 = $Node2D15/Marker2D.global_position
	var p13 = $Node2D16/Marker2D.global_position
	var p14 = $Node2D17/Marker2D.global_position
	var p15 = $Node2D18/Marker2D.global_position
	var p16 = $Node2D19/Marker2D.global_position
	var l = [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16]
	while o1 != 11:
		y = x.randi_range(0,16)
		l.append(y)
		o = l[y]
		print("o= ",o)
		o1 += 1 
		if o1 == 4 and typeof(o) == TYPE_VECTOR2:
			$"../AnimatedSprite2D".position = o
			print("no error")
		
		if o1 == 2 and typeof(o) == TYPE_VECTOR2:
			$"../AnimatedSprite2D2".position = o
			print("no error")
		
		if o1 == 3 and typeof(o) == TYPE_VECTOR2:
			$"../AnimatedSprite2D3".position = o
			print("no error")
		if o1 == 5 and typeof(o) == TYPE_VECTOR2:
			$"../Node2D3/AnimatedSprite2D4".position = o
			print("no error")
		if o1 == 6 and typeof(o) == TYPE_VECTOR2:
			$"../Node2D3/AnimatedSprite2D5".position = o
			print("no error")
		if o1 == 7 and typeof(o) == TYPE_VECTOR2:
			$"../Node2D3/AnimatedSprite2D6".position = o
			print("no error")
		if o1 == 8 and typeof(o) == TYPE_VECTOR2:
			$"../Node2D3/AnimatedSprite2D7".position = o
			print("no error")
		if o1 == 9 and typeof(o) == TYPE_VECTOR2:
			$"../Node2D3/AnimatedSprite2D8".position = o
			print("no error")
		if o1 == 10 and typeof(o) == TYPE_VECTOR2:
			$"../Player".position = o
			print("no error")
			$"../Distance Finder".position.x = $"../Player".position.x + 5
			$"../Distance Finder".position.y = $"../Player".position.y - 5
			nkcn = $"../Distance Finder".global_position
	_get_calculations()
