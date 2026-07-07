extends Node2D


func _ready() -> void:
	var fight_data = JsonLoader.load_fight_data("res://assets/fights_data/fight_timeline_for_tests.json")
	$FightManager.set_timeline(fight_data)
	Globals.player_health_label = $PlayerHealth

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		print(get_global_mouse_position())
