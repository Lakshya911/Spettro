extends CharacterBody2D
@export var Speed = 20
var node1 : bool = true
var node2 : bool = true
var node3 : bool = true
var km : float;
var x1;
var x2;
var y1;
var y2;
var c1 = 0
var x5 = 0
var x3 = 0
var x8;
var x9;
var x10;
var d1 = 0
var d2 = 0
var d3 = 0
var amtkey = 0
var n1;
var n2;
var n3;
var n4;
var n5;
var d4;
var txt;
var nkdc;
var tx2;
var d41 : bool = false
var g40 : float;
func _change():
	get_tree().change_scene_to_file.bind("res://Ded.tscn").call_deferred()
func _showtext(txt) -> void:
	$"../CanvasLayer2/Label3".text = txt
	$"../CanvasLayer2/Label3"/AnimationPlayer.play("new_animation")
func _do_distance_calc():
	x1 = $"../Ghost".global_position
	y2 = global_position
	d1 = y2.distance_to($"../Points".x8)
	d2 = y2.distance_to($"../Points".x9)
	d3 = y2.distance_to($"../Points".x10)
	#Distance b/w player and ghost
	x5 = y2.distance_to(x1)
	n1 = y2.distance_to($"../Points".n1)
	n2 = y2.distance_to($"../Points".n2)
	n3 = y2.distance_to($"../Points".n3)
	n4 = y2.distance_to($"../Points".n4)
	n5 = y2.distance_to($"../Points".n5)
	nkdc = y2.distance_to($"../Points".nkcn)
	km = y2.distance_to(Vector2(490,360))
	print("nkdc = ", nkdc)
func _equip(tx2):
	amtkey += tx2
	print("ok")
	$"../Sound/Equip".play()
func _ready():
	$"../CanvasLayer2/Label".text = ""
	$"../CanvasLayer2/Label2".text = ""
	$"../CanvasLayer2/Label3".text = ""
	$"../CanvasLayer2/Label4".text = ""
	_showtext("Pick up the device using E")  #Replace E with control when control system is working
	preload("res://Ded.tscn")
	#Distance b/w player and keys
	$"../CanvasLayer".visible = false
func _process(delta):
	d4 = Vector2(-116,-34)
	if velocity.x > 0:
		while true:
			velocity.x -= 20
	elif velocity.y > 0:
		while true:
			velocity.y -= 20
func _physics_process(delta):
	_do_distance_calc()
	print("d1 = ",d1)
	print("d2 = ",d2)
	print("d3 = ",d3)
	print("y2 = ",y2)
	if Input.is_action_pressed("w"):
		position.y -= Speed * delta
	if Input.is_action_pressed("s"):
		position.y += Speed * delta
	if Input.is_action_pressed("a"):
		position.x -= Speed * delta
	if Input.is_action_pressed("d"):
		position.x += Speed * delta
	move_and_slide()                   #Movement
	if $"../Ghost".visible == true or Input.is_key_label_pressed(KEY_P):    #Distance b/w ghost and player is less then change scene
		if x5 < 4 or Input.is_key_label_pressed(KEY_P):
			$"../Sound/Jumpscare".play()
			await get_tree().create_timer(2).timeout
			$"../Sound/Jumpscare".stop()
			$"../Sound/Woosh".play()
			$PointLight2D.energy = 0
			if $"../Sound/Woosh".finished:
				await get_tree().create_timer(0.7).timeout
				$".".hide()
				$"../ParallaxBackground".hide()
				await get_tree().create_timer(2).timeout
				$"../AnimatedSprite2D4".global_position = global_position
				$"../Sound/After Jumpscare".play()
				if $"../Sound/After Jumpscare".finished:
					await get_tree().create_timer(1.5).timeout
					_change()
					pass 
			print("true tooo")
	#IDK
	if Input.is_key_label_pressed(KEY_G):
		self.global_position = $"../AnimatedSprite2D".global_position
	if Input.is_action_just_pressed("k"):
		$"../CanvasModulate".color = Color(0 , 0 , 0)
		$"../ParallaxBackground".visible = true
	if Input.is_action_just_pressed("l"):
		$"../CanvasModulate".color = Color(1 , 1 , 1)
		$"../ParallaxBackground".visible = false
	#IDK!
	if Input.is_action_just_pressed("equip"):
		if d1 < 6:
			$"../AnimatedSprite2D".queue_free()
			_showtext("Key Equipped")
			_equip(1)
			node1 = false
		if d2 < 6:
			$"../AnimatedSprite2D2".queue_free()
			_showtext("Key Equipped")
			_equip(1)
			node2 = false
		if d3 < 6:
			$"../AnimatedSprite2D3".queue_free()
			_showtext("Key Equipped")
			_equip(1)
			node3 = false
		if n1 < 6:
			$"../Node2D3/AnimatedSprite2D4".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
		if n2 < 6:
			$"../Node2D3/AnimatedSprite2D5".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
		if n3 < 6:
			$"../Node2D3/AnimatedSprite2D6".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
		if n4 < 6:
			$"../Node2D3/AnimatedSprite2D7".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
		if n5 < 6:
			$"../Node2D3/AnimatedSprite2D8".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
		if km < 15:
			$"../Node2D3/AnimatedSprite2D8".position = Vector2(483,363)
			$"../Node2D3/AnimatedSprite2D7".position = Vector2(489,363)
			$"../Node2D3/AnimatedSprite2D6".position = Vector2(-149,-186)
			$"../Node2D3/AnimatedSprite2D5".position = Vector2(493,364)
			$"../Node2D3/AnimatedSprite2D4".position = Vector2(493,367)
		if nkdc < 5:
			_showtext("Equipped Distance Finder")
			$"../Distance Finder".hide()
			d41 = true
			await get_tree().process_frame
			_showtext("You can use this to find distance b/w you and the keys")
			$"../Sound/Equip".play()
	if Input.is_action_just_pressed("r") and amtkey == 8:
		pass
	if Input.is_action_just_pressed("esc") and $"../CanvasLayer".visible == false:
		$"../CanvasLayer".visible = true
		get_tree().paused = true
	elif Input.is_action_just_pressed("esc") and $"../CanvasLayer".visible == true:
		$"../CanvasLayer".visible = false
		get_tree().paused = false
	if d41 == true:
		$"../CanvasLayer2/Label4".text = "Distance: " + str(int(g40)) + "m"
		if node1 == true:
			g40 = d1
		elif node2 == true:
			g40 = d2
		elif node3 == false:
			g40 = d3
		else:
			$"../CanvasLayer2/Label4".text = ""
