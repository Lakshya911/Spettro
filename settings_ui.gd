extends CanvasLayer
var act : String;
func _action(act):
	InputMap.action_erase_events(act)
	InputMap.action_add_event(act, InputEventKey.new())
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


func _on_button_6_pressed() -> void:
	_action("w")
	$Settings/Button6.text = str(InputMap.action_get_events("w"))
