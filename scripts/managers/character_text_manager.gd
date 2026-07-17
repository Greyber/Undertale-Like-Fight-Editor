extends Node2D

var text_node : Label
var text : String
var writing : bool = true
var current_index : float = 0
var writing_speed : int = 15

func _ready() -> void:
	text_node = get_node("Text")

func start_writing(new_text:String) -> void:
	text = new_text
	text_node.text = ""
	current_index = 0
	write_character()

func write_character() -> void:
	text_node.text = text_node.text + text[current_index]
	current_index += 1
	if current_index < text.length():
		if text[current_index] == " ":
			text_node.text = text_node.text + text[current_index]
			current_index += 1
		get_tree().create_timer(1.0/writing_speed).timeout.connect(write_character)
	
func set_text_position(new_position:Vector2) -> void:
	text_node.position = new_position

func reset() -> void:
	text = ""
	text_node.text = text
