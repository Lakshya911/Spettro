extends Node2D
func _process(delta: float) -> void:
	if Input.is_key_label_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://Start Screen.tscn")
