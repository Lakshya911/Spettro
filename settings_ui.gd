extends CanvasLayer
func _ready() -> void:
	$Main.visible = true
	$Settings.visible = false
	$Map.visible = false
	$Inventory.visible = false

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

func _on_button_5_pressed() -> void:
	$Main.visible = false
	$Map.visible = false
	$Settings.visible = false
	$Inventory.visible = true

func _on_button_6_pressed() -> void:
	pass


func _physics_process(delta: float) -> void:
	if $Inventory.visible == true:
		if $"../Player".node1 == false:
			$"Inventory/GridContainer/Key 1".visible = true
		else:
			$"Inventory/GridContainer/Key 1".visible = false
		if $"../Player".node2 == false:
			$"Inventory/GridContainer/Key 2".visible = true
		else:
			$"Inventory/GridContainer/Key 2".visible = false
		if $"../Player".node3 == false:
			$"Inventory/GridContainer/Key 3".visible = true
		else:
			$"Inventory/GridContainer/Key 3".visible = false
		if $"../Player".node4 == false:
			$"Inventory/GridContainer/Nuke Part 1".visible = true
		else:
			$"Inventory/GridContainer/Nuke Part 1".visible = false
		if $"../Player".node5 == false:
			$"Inventory/GridContainer/Nuke Part 2".visible = true
		else:
			$"Inventory/GridContainer/Nuke Part 2".visible = false
		if $"../Player".node6 == false:
			$"Inventory/GridContainer/Nuke Part 3".visible = true
		else:
			$"Inventory/GridContainer/Nuke Part 3".visible = false
		if $"../Player".node7 == false:
			$"Inventory/GridContainer/Nuke Part 4".visible = true
		else:
			$"Inventory/GridContainer/Nuke Part 4".visible = false
		if $"../Player".node8 == false:
			$"Inventory/GridContainer/Nuke Part 5".visible = true
		else:
			$"Inventory/GridContainer/Nuke Part 5".visible = false
		if Input.is_action_just_pressed("esc"):
			$Inventory.visible = false
			$Main.visible = true
	if $"../Player".r1 == true:
		$"Map/Room 1".show()
	else:
		$"Map/Room 1".hide()
	if $"../Player".r2 == true:
		$"Map/Room 2".show()
	else:
		$"Map/Room 2".hide()
	if $"../Player".r3 == true:
		$"Map/Room 3".show()
	else:
		$"Map/Room 3".hide()
	if $"../Player".r4 == true:
		$"Map/Room 4".show()
	else:
		$"Map/Room 4".hide()
	if $"../Player".r5 == true:
		$"Map/Room 5".show()
	else:
		$"Map/Room 5".hide()
	if $"../Player".r6 == true:
		$"Map/Room 6".show()
	else:
		$"Map/Room 6".hide()
	if $"../Player".r7 == true:
		$"Map/Room 7".show()
	else:
		$"Map/Room 7".hide()
	if $"../Player".r8 == true:
		$"Map/Room 8".show()
	else:
		$"Map/Room 8".hide()
func _on_button_mouse_entered() -> void:
	$"../Sound/Menu".play()
