extends Button
var m;
func _ready() -> void:
	m = load("res://Tutorial.tscn")
func _process(delta):
	if $".".button_pressed == true:
		$"../../AudioStreamPlayer2D".play()
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_packed(m)


func _on_mouse_entered() -> void: 
	$"../../AudioStreamPlayer2D2".play()


func _on_pressed() -> void:
	$"../ColorRect3/AnimationPlayer".play("new_animation")
