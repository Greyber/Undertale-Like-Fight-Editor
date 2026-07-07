extends Node2D


func _ready() -> void:
	var fight_data = JsonLoader.load_fight_data("res://assets/fight_timeline.json")
	$FightManager.set_timeline(fight_data)
	Globals.player_health_label = $PlayerHealth

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == 1:
			#print(get_global_mouse_position())
