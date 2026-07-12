extends Control

var fight_data : FightData = FightData.new()
var fight_data_editor : FightData = FightData.new()


func _process(_delta: float) -> void:
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
			
			var event_data_for_editor : Dictionary= {'type': event.type, "time": event.time, "data":event.data}
			fight_data_editor.data.append(event_data_for_editor)
			
	var path : String = "res://assets/fights_data/fight_data.tres"
	var path2 : String = "res://assets/fights_data/fight_data_editor.tres"
	ResourceSaver.save(fight_data, path)
	ResourceSaver.save(fight_data_editor, path2)
	print("saved")

func import_data() -> void:
	var path : String = "res://assets/fights_data/fight_data_editor.tres"
	var data = ResourceLoader.load(path) as FightData
	for event in data.data:
		$TimeLine.add_event(Vector2(event['type'], event['time']), true, event['data'])
		


func _on_import_button_pressed() -> void:
	import_data()

func _on_measure_size_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$RectHelper.process_mode = Node.PROCESS_MODE_ALWAYS
		$RectHelper.visible = true
	else:
		$RectHelper.process_mode = Node.PROCESS_MODE_DISABLED
		$RectHelper.visible = false
