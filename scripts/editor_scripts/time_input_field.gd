extends Control

var target : Event

func _on_spin_box_value_changed(value: float) -> void:
	target.set_time(value)
	
func set_value(_value) -> void:
	$VBoxContainer/SpinBox.value = _value
