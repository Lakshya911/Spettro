extends Node2D

var x1;
var x2;
var y1;
var y2;
var dis;
var ok = 0
func _process(delta):
	x1 = $"../Player".global_position.x
	x2 = self.global_position.x
	
	y1 = $"../Player".global_position.y
	y2 = self.global_position.y
	
	dis = int(sqrt(int((x1 - x2))^2 + int((y1 - y2))^2))
	
	if dis < 10 and Input.is_action_just_pressed("equip") and $"../Player".amtkey == 8 :
		$"../Control/AnimationPlayer".play("KILL")
		queue_free()
		await get_tree().process_frame
		$"../Sound/Boom".play()
		print("Explosion Woooooo!")
		$"../Sound/Background Music".stop()
		$"../Sound/Late Game Background Music".play()
		$"../Ghost".x1 = 2
		$"../Ghost".y1 = 5
		$"../Ghost".o1 = 28
		$"../Ghost".o2 = 20
		$"../Node2D2".y = 0.048
		$"../Timer4".start()
		$"../CanvasLayer2/Label".text = "Survive for 3 minutes"
		

func _on_timer_4_timeout():
	$"../CanvasLayer2/Label2".text = "You Escaped.."
	$"../TileMap".queue_free()
	while ok < 10:
		await get_tree().process_frame
		ok += 1
	if ok == 9:
		get_tree().change_scene_to_file("res://Start Screen.tscn")
