extends Control

var text_input_field_scene : PackedScene = preload("res://scenes/editor/text_input_field.tscn")
var vector2_input_field_scene : PackedScene = preload("res://scenes/editor/vector_2_input_field.tscn")
var time_input_scene : PackedScene = preload("res://scenes/editor/time_input_field.tscn")
var proyectile_type_selector_scene : PackedScene = preload("res://scenes/editor/proyectile_type_select_field.tscn")

var event_scene : PackedScene = preload("res://scenes/editor/event.tscn")

var option_button : OptionButton
var fields_container : VBoxContainer
var target : Event

var proyectiles : Dictionary = {
		"proyectile_1": [],
		"proyectile_2": [{"name":"proyectile_position","type": "Vector2", "value":Vector2.ZERO}],
		"proyectile_3": [{"name":"proyectile_position","type": "Vector2", "value":Vector2.ZERO}, {"name":"proyectile_rotation","type": "float", "value":0}]
}

var text_to_index : Dictionary = {"proyectile_1":0, "proyectile_2":1, "proyectile_3":2}

func _ready() -> void:
	option_button = $OptionButton
	fields_container = $VBoxContainer
	_set_value()
	
#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("click"):
		#print(target.data)

func _set_value() -> void:
	var index : int = text_to_index[target.data[0]['value']]
	option_button.selected = index

func _on_option_button_item_selected(index: int) -> void:
	target.data = [{"name":"proyectile_name","type": "selector", "value":option_button.get_item_text(index)}] 
	for child in fields_container.get_children():
		child.queue_free()
	for property in proyectiles[option_button.get_item_text(index)]:
		FieldFactory.create_field(property, fields_container)
		target.data.append(property)
