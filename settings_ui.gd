extends CanvasLayer

func _ready() -> void:
	$Main.visible = true
	$Settings.visible = false
	$Map.visible = false

func _on_button_pressed() -> void:
		$".".visible = false
		get_tree().paused = false

func _on_button_2_pressed() -> void:
		$Main.visible = false
		$Settings.visible = true

func _on_button_3_pressed() -> void:
		get_tree().quit()

func _on_button_4_pressed() -> void:
	$Main.visible = false
	$Settings.visible = false
	$Map.visible = true

func _process(delta: float) -> void:
	if $Settings.visible == true and Input.is_action_just_pressed("esc"):
		$Settings.visible = false
		$Main.visible = true
	if $Map.visible == true and Input.is_action_just_pressed("esc"):
		$Map.visible = false
		$Main.visible = true


func _on_label_6_mouse_entered() -> void:
	if Input.is_action_just_pressed("mblft"):
		$Settings/Label6.text = "Press any key.."
		InputMap.action_erase_events("w")


func _on_label_5_mouse_entered() -> void:
		$Settings/Label6.text = "Press any key.."
		InputMap.action_erase_events("equip")
		#if Input.is_anything_pressed():
			#InputMap.action_add_event("equip",InputEventAction)

func _on_label_7_mouse_entered() -> void:
		$Settings/Label6.text = "Press any key.."
		#InputMap.action_erase_events("a")


func _on_label_8_mouse_entered() -> void:
		$Settings/Label6.text = "Press any key.."
		#InputMap.action_erase_events("s")


func _on_label_9_mouse_entered() -> void:
		$Settings/Label6.text = "Press any key.."
		#InputMap.action_erase_events("d")
