extends Node2D

var background : ColorRect
var target_position : Vector2 = Vector2(-100, -100)
var target_size : Vector2 = Vector2.ZERO

func _ready() -> void:
	background = $Background
	
func _process(delta: float) -> void:
	position = lerp(position, target_position, 10*delta)
	background.size = lerp(background.size, target_size, 10*delta)
	$RightBoundary.position.x = target_size.x
	$BottomBoundary.position.y = target_size.y
	
func set_arena_size(new_target_size: Vector2) -> void:
	target_size = new_target_size
	Globals.arena_size = target_size
	
func set_arena_position(new_target_position: Vector2) -> void :
	target_position = new_target_position
	Globals.arena_position = target_position
