extends CharacterBody2D
#region Variables
var op : Vector2;
@export var Speed : int = 20
var node1 : bool = true
var node2 : bool = true
var node3 : bool = true
var dashavail : bool = true
var node4 : bool = true
var node5 : bool = true
var node6 : bool = true
var node7 : bool = true
var node8 : bool = true
var km : float;
var x1 : Vector2;
var y2 : Vector2;
var x5 : float = 0
var d1 : float = 0
var d2 : float = 0
var d3 : float = 0
var amtkey : int = 0
var n1 : float;
var n2 : float;
var n3 : float;
var n4 : float;
var n5 : float;
var d4 : Vector2;
var txt : String;
var tx2 : int;
var d41 : bool = false
var g40 : float;
#endregion
#region Functions
func _change() -> void:
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
	km = y2.distance_to(Vector2(490,360))
func _equip(tx2):
	amtkey += tx2
	print("ok")
	$"../Sound/Equip".play()
#endregion
#region Other Functions
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	$"../CanvasLayer2/Label".text = ""
	$"../CanvasLayer2/Label2".text = ""
	$"../CanvasLayer2/Label3".text = ""
	$"../CanvasLayer2/Label4".text = ""
	_showtext("Pick up the device using E")  #Replace E with control when control system is working
	Speed = 0
	preload("res://Ded.tscn")
	#Distance b/w player and keys
	$"../CanvasLayer".visible = false
	$"../CanvasLayer3".visible = false
func _process(delta):
	if Input.is_key_label_pressed(KEY_O):
		get_tree().paused = true
	d4 = Vector2(-116,-34)
	if velocity.x > 0:
		while true:
			velocity.x -= 20
	elif velocity.y > 0:
		while true:
			velocity.y -= 20
#endregion
func _physics_process(delta):
#region Movement And Distance Calculations
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
#endregion
#region Jumpscare
	if $"../Ghost".visible == true or Input.is_key_label_pressed(KEY_P):    #Distance b/w ghost and player is less then change scene
		if x5 < 4 or Input.is_key_label_pressed(KEY_P):
			$"../CanvasLayer2/Label2".visible = false
			$"../CanvasLayer2/Label".visible = false
			$"../CanvasLayer2/Label3".visible = false
			$"../CanvasLayer2/Label4".visible = false
			
			Speed = 0
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
				$"../Sound/After Jumpscare".play()
				await get_tree().process_frame
				$"../CanvasLayer3".visible = true
				if $"../Sound/After Jumpscare".finished:
					await get_tree().create_timer(1.5).timeout
					_change()
					pass 
			print("true tooo")
#endregion
#region Debug
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
#endregion
#region Equipping
	if Input.is_action_just_pressed("equip"):
		Speed = 20
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
			$"../AnimatedSprite2D4".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
			node4 = false
		if n2 < 6:
			$"../AnimatedSprite2D5".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
			node5 = false
		if n3 < 6:
			$"../AnimatedSprite2D6".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
			node6 = false
		if n4 < 6:
			$"../AnimatedSprite2D7".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
			node7 = false
		if n5 < 6:
			$"../AnimatedSprite2D8".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
			node8 = false
		if km < 15:
			$"../AnimatedSprite2D8".position = Vector2(483,363)
			$"../AnimatedSprite2D7".position = Vector2(489,363)
			$"../AnimatedSprite2D6".position = Vector2(-149,-186)
			$"../AnimatedSprite2D5".position = Vector2(493,364)
			$"../AnimatedSprite2D4".position = Vector2(493,367)
		if $"Distance Finder".visible == true:
			_showtext("Equipped Distance Finder")
			$"Distance Finder".hide()
			d41 = true
			await get_tree().process_frame
			_showtext("You can use this to find distance b/w you and the keys")
			$"../Sound/Equip".play()
#endregion
#region Other Inputs
	if Input.is_action_just_pressed("mblft") and dashavail == true:
		dashavail = false
		global_position = $"../DashCursor".global_position
		$"../CanvasLayer2/ProgressBar".value = 0
		await get_tree().create_timer(5).timeout
		dashavail = true
	if Input.is_action_just_pressed("esc") and $"../CanvasLayer".visible == false:
		$"../CanvasLayer".visible = true
		get_tree().paused = true
	elif Input.is_action_just_pressed("esc") and $"../CanvasLayer".visible == true:
		$"../CanvasLayer".visible = false
		get_tree().paused = false
	if dashavail == true:
		$"../CanvasLayer2/ProgressBar".value = 1
	elif dashavail == false:
		$"../CanvasLayer2/ProgressBar".value = 0
#endregion
#region Text
	if d41 == true:
		$"../CanvasLayer2/Label4".text = "Distance: " + str(int(g40)) + "m"
		if node1 == true:
			g40 = d1
		elif node2 == true:
			g40 = d2
		elif node3 == true:
			g40 = d3
		elif node4 == true:
			g40 = n1
		elif node5 == true:
			g40 = n2
		elif node6 == true:
			g40 = n3
		elif node7 == true:
			g40 = n4
		elif node8 == true:
			g40 = n5
		else:
			$"../CanvasLayer2/Label4".text = "Error 404!"
#endregion
