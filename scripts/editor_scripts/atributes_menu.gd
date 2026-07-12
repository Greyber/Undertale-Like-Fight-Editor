extends Control

var text_input_field_scene : PackedScene = preload("res://scenes/editor_scenes/text_input_field.tscn")
var vector2_input_field_scene : PackedScene = preload("res://scenes/editor_scenes/vector_2_input_field.tscn")
var time_input_scene : PackedScene = preload("res://scenes/editor_scenes/time_input_field.tscn")

func _ready() -> void:
	EventManager.ON_SELECTED_EVENT_EDITOR.connect(handle_selected_event)
	
func handle_selected_event(_event):
	clear(_event)
	for property in _event.data:
		if property['type'] == "text":
			var text_input = text_input_field_scene.instantiate()
			text_input.target = property
			text_input.type = "text"
			text_input.set_value(property['value'], property['name'])
			$VBoxContainer.add_child(text_input)
		elif property['type'] == "float":
			var text_input = text_input_field_scene.instantiate()
			text_input.target = property
			text_input.type = "float"
			text_input.set_value(property['value'], property['name'])
			$VBoxContainer.add_child(text_input)
		elif property['type'] == "int":
			var text_input = text_input_field_scene.instantiate()
			text_input.target = property
			text_input.type = "int"
			text_input.set_value(property['value'], property['name'])
			$VBoxContainer.add_child(text_input)
		elif property['type'] == 'Vector2':
			var vector2_input = vector2_input_field_scene.instantiate()
			vector2_input.target = property
			vector2_input.set_value(property['value'], property['name'])
			$VBoxContainer.add_child(vector2_input)
		
func clear(_event) -> void:
	for child in $VBoxContainer.get_children():
		if child.name == "TimeInputField": continue
		child.queue_free()
	$TimeInputField.target = _event
	$TimeInputField.set_value(_event.time)
