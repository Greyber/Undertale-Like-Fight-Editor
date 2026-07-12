extends Control


var target : Dictionary
var type = "text"

func _on_line_edit_text_changed(new_text: String) -> void:
	if type == "text":
		target["value"] = new_text
	elif type == "int":
		target["value"] = int(new_text)
	elif type == "float":
		target['value'] = float(new_text)
	
func set_value(_value, propertie_name):
	$VBoxContainer/Label.text = propertie_name
	$VBoxContainer/LineEdit.text = str(target['value'])
