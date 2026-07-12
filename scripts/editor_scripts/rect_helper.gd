extends Control


var start_position : Vector2
var color_rect : ColorRect
var label : Label
var fixed_label : Label
var measuring : bool = false

func _ready() -> void:
	color_rect = $Control/ColorRect
	label = $Control/MouseLabel
	fixed_label = $FixedLabel
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		var mpos = get_local_mouse_position()
		if event.pressed:
			if not (mpos.x > 194 and mpos.y > 63 and mpos.x < 533 + 194 and mpos.y < 300 + 63): return 
			$Control.visible = true
			start_position = mpos
			color_rect.position = start_position
			measuring = true
		else: 
			$Control.visible = false
			fixed_label.text = label.text
			measuring = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not measuring: return
	var red_factor : float = Globals.editor_viewport_reduction_factor
	var mpos = get_local_mouse_position()
	color_rect.size = mpos - start_position
	label.position = mpos - Vector2(0, 20)
	var rect_size = str(color_rect.size.x*red_factor) + " : " + str(color_rect.size.y*red_factor)
	label.text = rect_size
