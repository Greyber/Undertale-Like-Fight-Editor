extends Control


var target : Dictionary
var value : Vector2 = Vector2(0, 0)

func set_value(_value, property_name):
	$HBoxContainer/Label.text = property_name
	$HBoxContainer/VBoxContainer/VBoxContainer/LineEdit.text = str(_value.x)
	$HBoxContainer/VBoxContainer/VBoxContainer2/LineEdit2.text  = str(_value.y)
	
func _on_line_edit_text_changed(new_text: String) -> void:
	value.x = float(new_text)
	target['value'] = value


func _on_line_edit_2_text_changed(new_text: String) -> void:
	value.y = float(new_text)
	target['value'] = value
