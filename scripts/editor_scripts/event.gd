extends Panel
class_name Event

var id : int
var data : Array
var time : float
var type : Globals.EventTypes

func _ready() -> void:
	custom_minimum_size = Vector2(50, 50)
	
func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		EventManager.ON_SELECTED_EVENT_EDITOR.emit(self)
