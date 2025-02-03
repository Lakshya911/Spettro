extends Node2D

var x1;
var y1;
var dis;
var ok = 0
func _process(delta):
	x1 = $"../Player".global_position
	y1 = self.global_position
	dis = y1.distance_to(x1)
	
	if dis < 60 and $"../Player".amtkey > 7:
		$"../Player"._showtext("Go near area and press E")
	
	if (dis < 90 and Input.is_action_just_pressed("equip") and $"../Player".amtkey > 7):
		$"../Sound/Boom".play()
		$"../CanvasLayer2/ColorRect3/AnimationPlayer".play("KILL")
		self.queue_free()
		print("Explosion Woooooo!")
		$"../Sound/Background Music".stop()
		$"../Sound/Late Game Background Music".play()
		$"../Ghost".x1 = 2
		$"../Ghost".y1 = 5
		$"../Ghost".o1 = 30
		$"../Ghost".o2 = 23
		$"../Node2D2".y = 0.048
		$"../Timer4".start()
		$"../Player"._showtext("Survive for 3 minutes")
		

func _on_timer_4_timeout():
	$"../CanvasLayer2/Label2".text = "You Escaped.."
	$"../TileMap".queue_free()
	while ok < 10:
		await get_tree().process_frame
		ok += 1
	if ok == 9:
		get_tree().change_scene_to_file("res://Start Screen.tscn")
