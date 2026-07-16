extends Node

var proyectile_1 : PackedScene = preload("uid://cj1uehjc7vq7f")
var proyectile_2 : PackedScene = preload("uid://be4ya6w2as7l4")

var pools : Dictionary[String, Array] = {'proyectile_1':[], "proyectile_2":[]}

func add_queue(obj_type, obj) -> void:
	pools[obj_type].append(obj)
	obj.process_mode = Node.PROCESS_MODE_DISABLED

func request_queue(obj_type) -> BaseProyectile:
	var proyectile : BaseProyectile
	if pools[obj_type]:
		proyectile = pools[obj_type][0]
		pools[obj_type][0].reset_values()
		pools[obj_type][0].process_mode = Node.PROCESS_MODE_ALWAYS
		pools[obj_type].pop_front()
	else:
		match obj_type:
			"proyectile_1":
				proyectile = proyectile_1.instantiate()
			"proyectile_2":
				proyectile = proyectile_2.instantiate()
		add_child(proyectile_2.instantiate())
	return proyectile
