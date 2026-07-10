extends Node
class_name JsonLoader

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
