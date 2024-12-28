extends CharacterBody2D
var k : bool = true
func _process(delta: float) -> void:
	if $"../Player".dashavail == true and k == true:
		$"../DashCursor".global_position = get_global_mouse_position()
	move_and_slide()
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("cursor"):
		k = false
		print("area")
