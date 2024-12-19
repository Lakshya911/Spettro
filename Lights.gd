extends PointLight2D
var x = 100
var y = 0
func _on_timer_timeout():
	$"../Player/DirectionalLight2D".energy = x
	$"../Sound/Light".play()
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	$"../Sound/Light".play()
	await get_tree().process_frame
	await get_tree().process_frame
	$"../Player/DirectionalLight2D".energy = y
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	$"../Sound/Light".play()
	await get_tree().process_frame
	await get_tree().process_frame
	$"../Player/DirectionalLight2D".energy = x
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	$"../Sound/Light".play()
	await get_tree().process_frame
	await get_tree().process_frame
	$"../Player/DirectionalLight2D".energy = y
	$"../Timer".start()
