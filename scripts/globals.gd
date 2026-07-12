extends Node

var viewport_size : Vector2 = Vector2(1152, 648)
var aspect_ratio = viewport_size.x / viewport_size.y
var editor_viewport_reduction_factor : float = 2.16

enum EventTypes {
	SPAWN_PROYECTILE,
	SPAWN_NPC,
	WRITE_DIALOGUE,
	SET_DIALOGUE_POSITION,
	CHANGE_ARENA,
	SET_PLAYER_POSITION,
	START_FIGHT_MENU,
	SHOW_DIALOGUE_ANSWERS,
	SET_TIMELINE_TIME,
	JUMP_IF_ANSWER
}

var event_just_created = false
var arena_size : Vector2
var arena_position : Vector2
var player : CharacterBody2D
var player_health_label : Label
