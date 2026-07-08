extends Control


var target : Dictionary
var value : Vector2 = Vector2(0, 0)

func _on_line_edit_text_changed(new_text: String) -> void:
	value.x = int(new_text)
	target['value'] = value


func _on_line_edit_2_text_changed(new_text: String) -> void:
	value.y = int(new_text)
	target['value'] = value
	print(target)
