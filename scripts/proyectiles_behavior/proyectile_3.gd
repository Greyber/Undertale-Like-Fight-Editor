extends BaseProyectile

var timer : float = 0
var speed_1 : float = 4
var speed_2 : float = 1500
var target_direction : Vector2
var initial_target_position : Vector2 = Vector2(500, 500)
var phase : int = 0

func _ready() -> void:
	reset_values()

func _process(delta: float) -> void:
	if phase == 0:
		if (position-initial_target_position).length() > 10:
			position = lerp(position, initial_target_position, speed_1*delta)
			return
		phase = 1
	elif phase == 1:
		if timer < 1:
			look_at(Globals.player.position)
			target_direction = (Globals.player.position - position).normalized()
		else:
			position += target_direction*speed_2*delta
		timer += delta
		if timer > 3:
			reset_values()
			
func reset_values() -> void:
	position = Vector2(600, -100)
	_set_initial_target_position()
	look_at(initial_target_position)
	phase = 0
	timer = 0

func _set_initial_target_position():
	var points = [Globals.arena_position, Globals.arena_position+Globals.arena_size]
	initial_target_position = points.pick_random()
