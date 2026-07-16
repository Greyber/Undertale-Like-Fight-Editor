extends Node2D

func spawn_proyectile(event:Dictionary) -> void:
	var proyectile = PoolManager.request_queue(event['entity'])
