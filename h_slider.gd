extends HSlider
var x = RandomNumberGenerator.new()
func _ready() -> void:
	value = $".".max_value - x.randi_range(1,3)
func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _process(delta: float) -> void:
	if $".".value == -15:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
