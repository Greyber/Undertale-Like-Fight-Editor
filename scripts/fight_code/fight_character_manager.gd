extends Node2D

var npcs_images : Dictionary = {'yae miko':preload("res://assets/yae miko.png"), 'yae_miko_2':preload("res://assets/yae miko 2.png")}
var target_position = Vector2.ZERO
var current_npc : String = ''
var can_npc_dodge : bool = true
var movement_speed : float

func _ready() -> void:
	EventManager.ON_CHARACTER_TAKE_DAMAGE.connect(take_damage)
	

func _process(delta: float) -> void:
	if current_npc:
		$Character.position = lerp($Character.position, target_position, 10 * delta)

func spawn_npc(npc_name) -> void:
	current_npc = npc_name
	$Character.texture = npcs_images[npc_name]
	
func move_npc(pos : Vector2, speed: float = 10.0) -> void:
	target_position = pos
	movement_speed = speed 

func take_damage() -> void:
	$SlashAnimation.visible = true
	$SlashAnimation.play("new_animation")
	$SlashAnimation.animation_finished.connect(func() : $SlashAnimation.visible = false)
	var anim : Animation = $AnimationPlayer.get_animation("hit")
	if not can_npc_dodge: 
		anim.track_set_key_value(0, 0, $Character.position)
		anim.track_set_key_value(0, 1, $Character.position + Vector2(0, -15))
		anim.track_set_key_value(0, 2, $Character.position)
	else:
		anim.track_set_key_value(0, 0, $Character.position)
		anim.track_set_key_value(0, 1, $Character.position + Vector2(50, 0))
		anim.track_set_key_value(0, 2, $Character.position)
		
	$AnimationPlayer.current_animation = "hit"
	$AnimationPlayer.play()
	get_tree().create_timer(0.5).timeout.connect(func():EventManager.CONTINUE_TIMELINE.emit())
	
