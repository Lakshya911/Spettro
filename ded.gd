extends Control
var rg = RandomNumberGenerator.new()
func _ready() -> void:
	$Jumpscare.pitch_scale = rg.randfn(-6.24,2.6)



func _on_jumpscare_finished() -> void:
	await get_tree().create_timer(0.1).timeout
	$CanvasLayer3.hide()
	$Jumpscare.stop()
	$Music.play()
