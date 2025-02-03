extends CharacterBody2D
func _process(delta: float) -> void:
	if $"..".dashavail == true and $"..".dsh < 20 and $"..".MsWord == true:
		$".".global_position = get_global_mouse_position()
		move_and_slide()
	else:
		$".".global_position = $"..".global_position
