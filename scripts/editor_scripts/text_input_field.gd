extends Control


var target : Dictionary

func _on_line_edit_text_changed(new_text: String) -> void:
	target["value"] = new_text
