extends Control

func _ready() -> void:
	EventManager.ON_SELECTED_EVENT_EDITOR.connect(handle_selected_event)
	
func handle_selected_event(_event):
	Globals.selected_event = _event
	clear(_event)
	for property in _event.data:
		FieldFactory.create_field(property, $VBoxContainer)
		
func clear(_event) -> void:
	for child in $VBoxContainer.get_children():
		if child.name == "TimeInputField": continue
		child.queue_free()
	$TimeInputField.target = _event
	$TimeInputField.set_value(_event.time)
