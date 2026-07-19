extends Panel
class_name Event

var id : int
var data : Array
var time : float
var type : Globals.EventTypes

func _ready() -> void:
	custom_minimum_size = Vector2(50, 50)
	
func _gui_input(_event: InputEvent) -> void:
	#if _event is InputEventMouseButton and _event.button_index == 1 and _event.pressed:
		#print(data)
	if Input.is_action_just_pressed("click"):
		Globals.selected_event = self
		EventManager.ON_SELECTED_EVENT_EDITOR.emit()

func set_data(_data:Array):
	for property in _data:
		data.append(property.duplicate(true))
		
func set_time(_time: float) -> void:
	position.x = _time * 100
	time = snapped(_time, 0.1)
	$Label.text = str(time)
