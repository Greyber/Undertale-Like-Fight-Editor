extends Node2D

func _ready() -> void:
	load_fight_data()

func load_fight_data() -> void:
	var path : String = "res://assets/fights_data/fight_data.tres"
	var fight_data = ResourceLoader.load(path) as FightData
	print(fight_data.data)
	if fight_data == null: print('error')
	$FightManager.set_timeline(fight_data)
	Globals.player_health_label = $PlayerHealth

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		#print(get_global_mouse_position())
