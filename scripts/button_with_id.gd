extends Button
class_name ButtonWihID

signal on_pressed(id)
var id

func _ready() -> void:
	pressed.connect(func() : on_pressed.emit(self.id))
