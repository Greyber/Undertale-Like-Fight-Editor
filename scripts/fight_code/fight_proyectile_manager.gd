extends Node2D

func spawn_proyectile(event:Dictionary) -> void:
	var proyectile = PoolManager.request_queue(event['proyectile_name'])
	match event['proyectile_name']:
		"proyectile_1":
			pass
		"proyectile_2":
			pass
		"proyectile_3":
			pass
