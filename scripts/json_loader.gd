extends Node
class_name JsonLoader

static var events_text_to_enum : Dictionary = {"SET_PLAYER_POSITION": Globals.EventTypes.SET_PLAYER_POSITION,
							"SPAWN_NPC": Globals.EventTypes.SPAWN_NPC,
							"SET_DIALOGUE_POSITION": Globals.EventTypes.SET_DIALOGUE_POSITION,
							"WRITE_DIALOGUE": Globals.EventTypes.WRITE_DIALOGUE,
							"CHANGE_ARENA": Globals.EventTypes.CHANGE_ARENA,
							"START_FIGHT_MENU": Globals.EventTypes.START_FIGHT_MENU,
							"SPAWN_PROYECTILE": Globals.EventTypes.SPAWN_PROYECTILE,
							"SHOW_DIALOGUE_ANSWERS": Globals.EventTypes.SHOW_DIALOGUE_ANSWERS,
							"JUMP_IF_ANSWER": Globals.EventTypes.JUMP_IF_ANSWER}

static func read_json_from_file(path: String) -> Array:
	if FileAccess.file_exists(path):
		var file : FileAccess = FileAccess.open(path, FileAccess.READ)
		var json : Array = JSON.parse_string(file.get_as_text())
		return json
	else:
		print("File not found: " + path)
		return []

static func save_json_to_file(path: String, data: Variant) -> void:
	var file : FileAccess = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))


static func load_fight_data(path:String) -> Array:
	var data : Array = read_json_from_file(path)
	for event : Dictionary in data:
		if 'position' in event:
			event['position'] = Vector2(event['position']['x'],event['position']['y'])
		if 'size' in event:
			event['size'] = Vector2(event['size']['x'],event['size']['y'])
		event['type'] = events_text_to_enum[event['type']]
	return data
