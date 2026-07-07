extends BaseProyectile

var angle = 0
var distance = 700
	
func _process(delta: float) -> void:
	angle += 0.05 / (distance*0.005)
	distance -= 1
	position = Vector2(cos(angle)*distance, sin(angle)*distance) + Globals.viewport_size/2
	if distance < 1:
		terminate()
