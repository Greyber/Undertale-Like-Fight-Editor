extends Control

func _ready() -> void:
	EventManager.ON_SELECTED_EVENT_EDITOR.connect(handle_selected_event)
	
func handle_selected_event():
	var event : Event = Globals.selected_event
	clear()
	$TimeInputField.target = event
	$TimeInputField.set_value(event.time)
	for property in event.data:
		FieldFactory.create_field(property, $VBoxContainer)
		
func clear() -> void:
	for child in $VBoxContainer.get_children():
		if child.name == "TimeInputField": continue
		child.queue_free()
	
