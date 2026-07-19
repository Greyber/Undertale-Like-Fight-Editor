extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == 49:
			$EditorContainer.process_mode = Node.PROCESS_MODE_ALWAYS
			$EditorContainer.visible = true
			$Main.process_mode = Node.PROCESS_MODE_DISABLED
			$Main.visible = false
		elif event.keycode == 50:
			$EditorContainer.process_mode = Node.PROCESS_MODE_DISABLED
			$EditorContainer.visible = false
			$Main.process_mode = Node.PROCESS_MODE_ALWAYS
			$Main.visible = true
	
