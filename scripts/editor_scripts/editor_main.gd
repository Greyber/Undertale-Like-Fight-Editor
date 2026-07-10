extends Control

var fight_data : FightData = FightData.new()

var text_input_field_scene : PackedScene = preload("res://scenes/editor_scenes/text_input_field.tscn")
var vector2_input_field_scene : PackedScene = preload("res://scenes/editor_scenes/vector_2_input_field.tscn")
var time_input_scene : PackedScene = preload("res://scenes/editor_scenes/time_input_field.tscn")

func _ready() -> void:
	EventManager.ON_SELECTED_EVENT_EDITOR.connect(handle_selected_event)
	
func handle_selected_event(event):
	for child in $AtributesMenu/VBoxContainer.get_children():
		child.queue_free()
	var time_input = time_input_scene.instantiate()
	time_input.target = event
	time_input.set_value(event.time)
	$AtributesMenu/VBoxContainer.add_child(time_input)
	for property in event.data:
		if property['type'] == "text":
			var text_input = text_input_field_scene.instantiate()
			text_input.target = property
			$AtributesMenu/VBoxContainer.add_child(text_input)
		if property['type'] == 'Vector2':
			var vector2_input = vector2_input_field_scene.instantiate()
			vector2_input.target = property
			$AtributesMenu/VBoxContainer.add_child(vector2_input)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save"):
		export_data()

func export_data() -> void:
	for line in $TimeLine.lines:
		for event in line.get_children():
			if not event is Event: continue 
			var event_data : Dictionary
			event_data['type'] = event.type
			event_data['time'] = event.time
			for propertie in event.data:
				event_data[propertie['name']] = propertie['value']
			fight_data.data.append(event_data)
	print(fight_data.data)
	fight_data.id = 10
	var path : String = "res://assets/fights_data/fight_data.tres"
	var error : Error = ResourceSaver.save(fight_data, path)
	if error == OK:
		print("saved")
