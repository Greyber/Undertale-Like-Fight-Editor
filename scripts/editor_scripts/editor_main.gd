extends Node2D

var event_scene : PackedScene = preload("res://scenes/editor_scenes/event.tscn")

var zoom : float = 1
var offset : float = 0
var events : Array = []
var dragging : bool = false
var event_type_to_create = Globals.EventTypes.SPAWN_NPC

var EVENT_DATA_FORM  : Dictionary = {
	Globals.EventTypes.SPAWN_PROYECTILE:{
		"position": Vector2.ZERO
	},
	Globals.EventTypes.SPAWN_NPC:{
		"atributes": {"name":"npc_name",
		 			  "type": "string"}
	}
}

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.double_click:
			var mpos : Vector2 = event.position
			add_event(mpos)
		if event.button_index == 3:
			if event.pressed:
				dragging = true
			else:
				dragging = false
		if event.button_index == 4:
			update_zoom(0.1)
		if event.button_index == 5:
			update_zoom(-0.1)
	if dragging and event is InputEventMouseMotion:
		offset = max(0, offset-event.relative.x)
	update_events_local_positions()
	

func add_event(_position : Vector2) -> void:
	var event : Event = event_scene.instantiate()
	event.time = local_to_global(_position.x)
	events.append({"time":event.time, "type":event_type_to_create})
	add_child(event)
	
func update_events_local_positions() -> void:
	for event in events:
		event.position.x = global_to_local(event.time)
		event.position.y = 380
		
func _process(delta: float) -> void:
	pass

func update_zoom(new_zoom : float) -> void:
	var center = local_to_global(get_viewport_rect().size.x/2)
	zoom = max(0.1, zoom + new_zoom)
	offset = max(0, center * zoom - get_viewport_rect().size.x/2)
	
	
func global_to_local(value : float) -> float:
	return (value * zoom) - offset

func local_to_global(value : float) -> float:
	return (value + offset) / zoom
