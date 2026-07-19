extends BaseProyectile

var movement_speed : float = 500
var direction : int

func _process(delta: float) -> void:
	position.x += movement_speed * direction * delta
	if position.x > Globals.viewport_size.x or position.x < 0:
		terminate()
	
func reset_values() -> void:
	direction = [-1, 1].pick_random()
	position.x = 0.0 if direction == 1 else Globals.viewport_size.x
	position.y = randf_range(Globals.arena_position.y, Globals.arena_position.y + Globals.arena_size.y)
	visible = true

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body == Globals.player:
		EventManager.ON_PLAYER_TAKE_DAMAGE.emit()
