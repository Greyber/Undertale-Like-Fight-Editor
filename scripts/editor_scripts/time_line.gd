extends Control


var event_scene : PackedScene = preload("res://scenes/editor_scenes/event.tscn")

var id_increment = 0

const LINE_H  : int = 50
var LINE_W : int = 2000

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
		"properties": [{"name":"npc_name","type": "text", "value":""}, {"name":"npc_position","type": "Vector2", "value":Vector2.ZERO}]
	}
}

func _ready() -> void:
	create_lines()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.double_click:
		add_event(event.position)

func add_event(_position : Vector2) -> void:
	var line_index : int = int((_position.y - position.y)/ LINE_H)
	var line : Container = $HBoxContainer/ScrollContainer/VBoxContainer.get_children()[line_index]
	var event : Event = Event.new()
	event.id = id_increment
	id_increment += 1
	event.time = _position.x / 100
	event.type = Globals.EventTypes.SPAWN_NPC
	event.data = EVENT_DATA_FORM[event.type]['properties'].duplicate()
	event.position = Vector2(_position.x - $HBoxContainer/ScrollContainer.position.x + $HBoxContainer/ScrollContainer.scroll_horizontal, 0)
	line.add_child(event)
	
func update_events_local_positions() -> void:
	for event in events:
		event.position.x = global_to_local(event.time)
		event.position.y = 380
		
func update_zoom(new_zoom : float) -> void:
	var center = local_to_global(get_viewport_rect().size.x/2)
	zoom = max(0.1, zoom + new_zoom)
	offset = max(0, center * zoom - get_viewport_rect().size.x/2)
	
	
func global_to_local(value : float) -> float:
	return (value * zoom) - offset

func local_to_global(value : float) -> float:
	return (value + offset) / zoom

func create_lines() -> void:
	for i in range(4):
		var container : Container = Container.new()
		var panel : Panel = Panel.new()
		container.custom_minimum_size = Vector2(LINE_W, LINE_H)
		panel.custom_minimum_size = container.custom_minimum_size
		container.add_child(panel)
		$HBoxContainer/ScrollContainer/VBoxContainer.add_child(container)
