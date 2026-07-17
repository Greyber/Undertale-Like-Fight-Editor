extends Node
class_name FieldFactory

static var text_input_field_scene : PackedScene = preload("res://scenes/editor/text_input_field.tscn")
static var vector2_input_field_scene : PackedScene = preload("res://scenes/editor/vector_2_input_field.tscn")
static var time_input_scene : PackedScene = preload("res://scenes/editor/time_input_field.tscn")
static var proyectile_type_selector_scene : PackedScene = preload("res://scenes/editor/proyectile_type_select_field.tscn")

static func create_field(property, container) -> void:
	if property['type'] == "text" or property['type'] == "float" or property['type'] == "int":
		var text_input = text_input_field_scene.instantiate()
		text_input.target = property
		text_input.type = property['type']
		text_input.set_value(property['value'], property['name'])
		container.add_child(text_input)
	elif property['type'] == 'Vector2':
		var vector2_input = vector2_input_field_scene.instantiate()
		vector2_input.target = property
		vector2_input.set_value(property['value'], property['name'])
		container.add_child(vector2_input)
	elif property['type'] == "selector":
		var proyectile_type_selector = proyectile_type_selector_scene.instantiate()
		proyectile_type_selector.target = Globals.selected_event
		container.add_child(proyectile_type_selector)
