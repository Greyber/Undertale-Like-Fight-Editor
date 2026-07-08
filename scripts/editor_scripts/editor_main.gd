extends Control

var text_input_field_scene : PackedScene = preload("res://scenes/editor_scenes/text_input_field.tscn")
var vector2_input_field_scene : PackedScene = preload("res://scenes/editor_scenes/vector_2_input_field.tscn")
func _ready() -> void:
	EventManager.ON_SELECTED_EVENT_EDITOR.connect(handle_selected_event)
	
func handle_selected_event(event):
	for property in event.data:
		if property['type'] == "text":
			var text_input = text_input_field_scene.instantiate()
			text_input.target = property
			$AtributesMenu/VBoxContainer.add_child(text_input)
		if property['type'] == 'Vector2':
			var vector2_input = vector2_input_field_scene.instantiate()
			vector2_input.target = property
			$AtributesMenu/VBoxContainer.add_child(vector2_input)
			
