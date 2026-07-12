extends Panel

var get_position_active : bool = false

func _gui_input(event: InputEvent) -> void:
	if not get_position_active: return
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		var red_factor = Globals.editor_viewport_reduction_factor
		var mpos : String = str(int(event.position.x * red_factor)) + ":" + str(int(event.position.y * red_factor))
		$"/root/Editor/MPos".text = mpos




func _on_get_position_button_toggled(toggled_on: bool) -> void:
	if toggled_on: get_position_active = true
	else: get_position_active = false
