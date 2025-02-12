extends CharacterBody2D
#region Variables
var r1 : bool = false
var r2 : bool = false
var r3 : bool = false
var r4 : bool = false
var r5 : bool = false
var r6 : bool = false
var r7 : bool = false
var r8 : bool = false
var MsWord : bool = true
var pb : bool = false
var jmpscr : bool = false
var op : Vector2;
@export var Speed : int = 0
var dsh : float;
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
func _jumpscare() -> void:
	jmpscr = false
	_change()
func _change() -> void:
	get_tree().change_scene_to_file.bind("res://Ded.tscn").call_deferred()
func _showtext(txt) -> void:
	$"../CanvasLayer2/Label3/AnimationPlayer".stop()
	$"../CanvasLayer2/Label3".text = txt
	$"../CanvasLayer2/Label3"/AnimationPlayer.play("new_animation")
func _do_distance_calc() -> void:
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
	dsh = y2.distance_to($DashCursor.global_position)
func _equip(tx2) -> void:
	amtkey += tx2
	$"../Sound/Equip".play()
func setfalse():
	await get_tree().process_frame
	r1 = false
	r2 = false
	r3 = false
	r4 = false
	r5 = false
	r6 = false
	r7 = false
	r8 = false
#endregion
#region Other Functions
func _ready():
	$"../CanvasLayer2/AnimatedSprite2D".hide()
	$"../AnimatedSprite2D9/AnimationPlayer".play("RESET")
	$"../AnimatedSprite2D12/AnimationPlayer".play("RESET")
	$"../AnimatedSprite2D10/AnimationPlayer".play("RESET")
	$"../AnimatedSprite2D11/AnimationPlayer".play("RESET")
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	$"../CanvasLayer2/Label".text = ""
	$"../CanvasLayer2/Label2".text = ""
	$"../CanvasLayer2/Label3".text = ""
	$"../CanvasLayer2/Label4".text = ""
	$"../Sound/Heartbeat".stream_paused = true
	preload("res://Ded.tscn")
	#Distance b/w player and keys
	$"../CanvasLayer".visible = false
	_showtext("Pick up the device using E")  #Replace E with control when control system is working
	setfalse()
func _process(delta):
	$"../Sound/Heartbeat".pitch_scale = clamp(10.0 - 4.0 * abs(x5 - 5.0), 1, 20.0)
	if $"../Ghost".visible == true:
		$"../Sound/Heartbeat".stream_paused = false
	else:
		$"../Sound/Heartbeat".stream_paused = true
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
	if x5 < 4 or Input.is_key_label_pressed(KEY_I):    #Distance b/w ghost and player is less then change scene
		if $"../Ghost".visible == true or Input.is_key_label_pressed(KEY_I):
			_jumpscare()
#endregion
#region Debug
	#IDK
	#if Input.is_action_just_pressed("k"):
		#$"../CanvasModulate".color = Color(0 , 0 , 0)
		#$"../ParallaxBackground".visible = true
	#if Input.is_action_just_pressed("l"):
		#$"../CanvasModulate".color = Color(1 , 1 , 1)
		#$"../ParallaxBackground".visible = false
	#IDK!
#endregion
#region Equipping
	if Input.is_action_just_pressed("equip"):
		Speed = 20
		if d1 < 6 and $"../AnimatedSprite2D".is_inside_tree() == true:
			$"../AnimatedSprite2D".queue_free()
			_showtext("Key Equipped")
			_equip(1)
			node1 = false
		if d2 < 6 and $"../AnimatedSprite2D2".is_inside_tree() == true:
			$"../AnimatedSprite2D2".queue_free()
			_showtext("Key Equipped")
			_equip(1)
			node2 = false
		if d3 < 6 and $"../AnimatedSprite2D3".is_inside_tree() == true:
			$"../AnimatedSprite2D3".queue_free()
			_showtext("Key Equipped")
			_equip(1)
			node3 = false
		if n1 < 6 and $"../AnimatedSprite2D4".is_inside_tree() == true:
			$"../AnimatedSprite2D4".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
			node4 = false
		if n2 < 6 and $"../AnimatedSprite2D5".is_inside_tree() == true:
			$"../AnimatedSprite2D5".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
			node5 = false
		if n3 < 6 and $"../AnimatedSprite2D6".is_inside_tree() == true:
			$"../AnimatedSprite2D6".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
			node6 = false
		if n4 < 6 and $"../AnimatedSprite2D7".is_inside_tree() == true:
			$"../AnimatedSprite2D7".queue_free()
			_showtext("Equipped Nuke Part")
			_equip(1)
			node7 = false
		if n5 < 6 and $"../AnimatedSprite2D8".is_inside_tree() == true:
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
			pb = true
			$"../CanvasLayer2/AnimatedSprite2D".show()
			_showtext("Equipped Distance Finder")
			$"Distance Finder".hide()
			d41 = true
			$"../Sound/Equip".play()
#endregion
#region Other Inputs
	if amtkey > 8:
		_showtext("Go to Nuke Now")
	if Input.is_action_just_pressed("mblft") and dashavail == true and dsh < 20 and MsWord == true:
		dashavail = false
		global_position = $DashCursor.global_position
		$"../CanvasLayer2/ProgressBar".value = 0
		await get_tree().create_timer(5).timeout
		dashavail = true
	if Input.is_action_just_pressed("esc") and $"../CanvasLayer".visible == false:
		$"../CanvasLayer".visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
	elif Input.is_action_just_pressed("esc") and $"../CanvasLayer".visible == true:
		$"../CanvasLayer".visible = false
		get_tree().paused = false
	else:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	if dashavail == true:
		$"../CanvasLayer2/ProgressBar".value = 1
	elif dashavail == false:
		$"../CanvasLayer2/ProgressBar".value = 0
	if  dsh > 20:
		dashavail == false
#endregion
#region Text
	if d41 == true:
		$"../CanvasLayer2/Label4".text = "Distance  :" + str(int(g40)) + "m"
		if node1 == true:
			g40 = d1
			$"../CanvasLayer2/AnimatedSprite2D".set_animation("Keys")
			$"../CanvasLayer2/AnimatedSprite2D".set_frame(0)
			$"../CanvasLayer2/AnimatedSprite2D".scale = Vector2(3.68,3.68)
		elif node2 == true:
			g40 = d2
			$"../CanvasLayer2/AnimatedSprite2D".set_animation("Keys")
			$"../CanvasLayer2/AnimatedSprite2D".set_frame(1)
			$"../CanvasLayer2/AnimatedSprite2D".scale = Vector2(3.68,3.68)
		elif node3 == true:
			g40 = d3
			$"../CanvasLayer2/AnimatedSprite2D".set_animation("Keys")
			$"../CanvasLayer2/AnimatedSprite2D".set_frame(2)
			$"../CanvasLayer2/AnimatedSprite2D".scale = Vector2(3.68,3.68)
		elif node4 == true:
			g40 = n1
			$"../CanvasLayer2/AnimatedSprite2D".set_animation("Nuke parts")
			$"../CanvasLayer2/AnimatedSprite2D".set_frame(0)
			$"../CanvasLayer2/AnimatedSprite2D".scale = Vector2(5.465,5.465)
		elif node5 == true:
			g40 = n2
			$"../CanvasLayer2/AnimatedSprite2D".set_animation("Nuke parts")
			$"../CanvasLayer2/AnimatedSprite2D".set_frame(1)
			$"../CanvasLayer2/AnimatedSprite2D".scale = Vector2(5.465,5.465)
		elif node6 == true:
			g40 = n3
			$"../CanvasLayer2/AnimatedSprite2D".set_animation("Nuke parts")
			$"../CanvasLayer2/AnimatedSprite2D".set_frame(2)
			$"../CanvasLayer2/AnimatedSprite2D".scale = Vector2(5.465,5.465)
		elif node7 == true:
			g40 = n4
			$"../CanvasLayer2/AnimatedSprite2D".set_animation("Nuke parts")
			$"../CanvasLayer2/AnimatedSprite2D".set_frame(3)
			$"../CanvasLayer2/AnimatedSprite2D".scale = Vector2(5.465,5.465)
		elif node8 == true:
			g40 = n5
			$"../CanvasLayer2/AnimatedSprite2D".set_animation("Nuke parts")
			$"../CanvasLayer2/AnimatedSprite2D".set_frame(4)
			$"../CanvasLayer2/AnimatedSprite2D".scale = Vector2(5.465,5.465)
		else:
			$"../CanvasLayer2/Label4".text = "Error 404!"
#endregion
#region Doors
func _on_area_2d_body_entered(body: Node2D) -> void:
	if node1 == false and amtkey > 1:
		$"../AnimatedSprite2D10/AnimationPlayer".play("new_animation")
	else:
		_showtext("You require a key!")
		print("You require a key!")
func _on_area_1d_body_entered(body: Node2D) -> void:
	if node2 == false and amtkey > 1:
		$"../AnimatedSprite2D11/AnimationPlayer".play("new_animation")
	else:
		_showtext("You require a key!")
		print("You require a key!")
func _on_area_0d_body_entered(body: Node2D) -> void:
	if node3 == false and amtkey > 1:
		$"../AnimatedSprite2D9/AnimationPlayer".play("new_animation")
	else:
		_showtext("You require a key!")
		print("You require a key!")
func _on_area_8d_body_entered(body: Node2D) -> void:
	if (node1 == false or node2 == false or node3 == false) and amtkey > 1:
		$"../AnimatedSprite2D12/AnimationPlayer".play("new_animation")
	else:
		_showtext("You require a key!")
		print("You require a key!")
#endregion
#region Area Nodes
func _on_room_1_body_entered(body: Node2D) -> void:
	r1 = true
func _on_room_2_body_entered(body: Node2D) -> void:
	r2 = true
func _on_room_3_body_entered(body: Node2D) -> void:
	r3 = true
func _on_room_4_body_entered(body: Node2D) -> void:
	r4 = true
func _on_room_5_body_entered(body: Node2D) -> void:
	r5 = true
func _on_room_6_body_entered(body: Node2D) -> void:
	r6 = true
func _on_room_7_body_entered(body: Node2D) -> void:
	r7 = true
func _on_room_8_body_entered(body: Node2D) -> void:
	r8 = true
func _on_room_1_body_exited(body: Node2D) -> void:
	r1 = false
func _on_room_2_body_exited(body: Node2D) -> void:
	r2 = false
func _on_room_3_body_exited(body: Node2D) -> void:
	r3 = false
func _on_room_4_body_exited(body: Node2D) -> void:
	r4 = false
func _on_room_5_body_exited(body: Node2D) -> void:
	r5 = false
func _on_room_6_body_exited(body: Node2D) -> void:
	r6 = false
func _on_room_7_body_exited(body: Node2D) -> void:
	r7 = false
func _on_room_8_body_exited(body: Node2D) -> void:
	r8 = false
func _on_mouse_entered() -> void:
	MsWord = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	print("YO MOUSE")
func _on_mouse_exited() -> void:
	MsWord = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	print("YO NO MOUSE")
