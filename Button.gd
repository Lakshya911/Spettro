extends Button


func _process(delta):
	if $".".button_pressed == true:
		$"../../AudioStreamPlayer2D".play()
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://Tutorial.tscn")


func _on_mouse_entered() -> void: 
	$"../../AudioStreamPlayer2D2".play()
