extends Node2D


func _ready() -> void:
	var path : String = "res://assets/fights_data/fight_data.tres"
	var fight_data = ResourceLoader.load(path) as FightData
	if fight_data == null: print('error')
	print(fight_data.id)
	$FightManager.set_timeline(fight_data)
	Globals.player_health_label = $PlayerHealth

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		print(get_global_mouse_position())
