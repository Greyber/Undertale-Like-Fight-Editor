extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var button : ButtonWihID = ButtonWihID.new()
	button.text = "PABLO"
	button.on_pressed.connect(func(id): print("hello"))
	add_child(button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
