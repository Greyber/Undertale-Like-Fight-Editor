extends CharacterBody2D


const SPEED : float = 300.0
const JUMP_VELOCITY : float = -400.0

var health : float = 100

var dashing : bool = false
var dashing_duration : float = 0.1
var dashing_timer : float = dashing_duration
var dashing_velocity : Vector2 = Vector2.ZERO
var dashing_speed : float = 700.0

func _ready() -> void:
	Globals.player = self
	EventManager.ON_PLAYER_TAKE_DAMAGE.connect(take_damage)

func _physics_process(delta: float) -> void:
	if not dashing:
		var direction_x := Input.get_axis("ui_left", "ui_right")
		var direction_y := Input.get_axis("ui_up", "ui_down")
		if Input.is_action_just_pressed("dash"):
			dashing = true
			dashing_velocity = Vector2(direction_x, direction_y).normalized()
		if direction_x or direction_y:
			velocity.x = direction_x * SPEED
			velocity.y = direction_y * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
		velocity.normalized()
	elif dashing:
		dashing_timer -= delta
		velocity = dashing_velocity * dashing_speed
		if dashing_timer < 0:
			dashing = false
			dashing_timer = dashing_duration
	move_and_slide()

func take_damage() -> void:
	health -= 10
	Globals.player_health_label.text = str(health)
