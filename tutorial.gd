extends Node2D
var txt : String;
var x : int;
var y : float = 0.0
var skip : bool = false
var os = "res://Main.tscn"
var prg = []
var ak;
func dostuff(txt : String , x : int) -> void:
	$Label/AnimationPlayer.play("new_animation")
	$Label3/AnimationPlayer.play("new_animation")
	if $Label/AnimationPlayer.animation_finished:
		$Label.text = txt
		$Label3.text = txt
		await get_tree().create_timer(x).timeout
		$Label/AnimationPlayer.play("new_animation_2")
		$Label3/AnimationPlayer.play("new_animation_2")

func dodostuff() -> void:
	await get_tree().create_timer(1.1).timeout
	dostuff("I have been trying to run away from spettro for quite some time now",5)
	await get_tree().create_timer(6).timeout
	dostuff("Now I just need to find the 5 nuke parts to blow this place up so nobody is ever hurt again..",5)
	await get_tree().create_timer(6).timeout
	dostuff("I already have the teleporter so i can teleport in a limited zone to get away from him..",6)
	await get_tree().create_timer(7).timeout
	dostuff("You can use LMB to teleport and to find the map press escape and to equip press E",5)
	await get_tree().create_timer(6).timeout
	dostuff("You can use the distance finder to find the ditance to the items",5)
	await get_tree().create_timer(6).timeout
	dostuff("You may get stuck to walls",3)
	await get_tree().create_timer(4).timeout
	dostuff("Good Luck...You will need it",3)
func _ready() -> void:
	$ColorRect3/AnimationPlayer.play("new_animation")
	if skip == false:
		dodostuff()
		await get_tree().create_timer(41).timeout
		$CanvasLayer.visible = true
		$CanvasLayer/ProgressBar/AnimationPlayer.play("new_animation")
		$CanvasLayer/Label/AnimationPlayer.play("new_animation")
		if $CanvasLayer/ProgressBar/AnimationPlayer.animation_finished:
			await get_tree().create_timer(6).timeout
			get_tree().change_scene_to_file("res://Main.tscn")
	ResourceLoader.load_threaded_request(os,prg)
func _process(delta: float) -> void:
	if Input.is_key_label_pressed(KEY_SPACE) and skip == false:
		skip = true
	print(skip)
	if skip == true:
		$Label.visible = false
		$Label2.visible = false
		$CanvasLayer.visible = true
		$CanvasLayer/ProgressBar/AnimationPlayer.play("new_animation")
		$CanvasLayer/Label/AnimationPlayer.play("new_animation")
		if $CanvasLayer/ProgressBar/AnimationPlayer.animation_finished and ResourceLoader.THREAD_LOAD_LOADED:
			ak = ResourceLoader.load_threaded_get(os)
			await get_tree().create_timer(6).timeout
			get_tree().change_scene_to_packed(ak)
