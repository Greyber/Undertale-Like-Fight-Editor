extends Control

var text_input_field_scene : PackedScene = preload("res://scenes/editor_scenes/text_input_field.tscn")
var vector2_input_field_scene : PackedScene = preload("res://scenes/editor_scenes/vector_2_input_field.tscn")
var time_input_scene : PackedScene = preload("res://scenes/editor_scenes/time_input_field.tscn")
var proyectile_type_selector_scene : PackedScene = preload("res://scenes/editor_scenes/proyectile_type_select_field.tscn")

var event_scene : PackedScene = preload("res://scenes/editor_scenes/event.tscn")

var option_button : OptionButton
var target : Event

var proyectiles : Dictionary = {
		"proyectile1": [],
		"proyectile2": [{"name":"proyectile_position","type": "Vector2", "value":Vector2.ZERO}],
		"proyectile3": [{"name":"proyectile_position","type": "Vector2", "value":Vector2.ZERO}, {"name":"proyectile_rotation","type": "float", "value":0}]
}

var items = {0:"proyectile1", 1:"proyectile2", 2:"proyectile3"}

func _ready() -> void:
	option_button = $OptionButton
	target = Event.new()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		print(target.data)

func set_value(_value):
	pass

func _on_option_button_item_selected(index: int) -> void:
	target.data = [{"name":"npc_position","type": "selector", "value":""}] 
	for child in $VBoxContainer.get_children():
		child.queue_free()
	for property in proyectiles[items[index]]:
		var property_dup : Dictionary = property.duplicate()
		target.data.append(property_dup)
		if property['type'] == "text":
			var text_input = text_input_field_scene.instantiate()
			text_input.target = property_dup
			text_input.type = "text"
			text_input.set_value(property['value'], property['name'])
			$VBoxContainer.add_child(text_input)
		elif property['type'] == "float":
			var text_input = text_input_field_scene.instantiate()
			text_input.target = property_dup
			text_input.type = "float"
			text_input.set_value(property['value'], property['name'])
			$VBoxContainer.add_child(text_input)
		elif property['type'] == "int":
			var text_input = text_input_field_scene.instantiate()
			text_input.target = property_dup
			text_input.type = "int"
			text_input.set_value(property['value'], property['name'])
			$VBoxContainer.add_child(text_input)
		elif property['type'] == 'Vector2':
			var vector2_input = vector2_input_field_scene.instantiate()
			vector2_input.target = property_dup
			vector2_input.set_value(property['value'], property['name'])
			$VBoxContainer.add_child(vector2_input)
