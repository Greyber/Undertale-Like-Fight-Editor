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
var lines : Array = []

var EVENT_DATA_FORM  : Dictionary = {
	Globals.EventTypes.SPAWN_PROYECTILE:{
		"label" : "spawn_proyectile",
		"properties": [{"name":"npc_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.SPAWN_NPC:{
		"label": "spawn_npc",
		"properties": [{"name":"npc_name","type": "text", "value":""}, {"name":"npc_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.PAUSE: {
		"label": "pause",
		"properties": [{"name":"npc_name","type": "text", "value":""}, {"name":"npc_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.MENU: {
		"label": "menu",
		"properties": [{"name":"npc_name","type": "text", "value":""}, {"name":"npc_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.CHANGE_ARENA:{
		'label':"change_area",
		"properties": [{"name":"arena_position","type": "Vector2", "value":Vector2.ZERO}, {"name":"arena_size","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.SET_PLAYER_POSITION:{
		"label": "set_player_position",
		"properties": [{"name":"player_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.WRITE_DIALOGUE:{
		"label": "write_dialogue",
		"properties": [{"name":"dialogue_content","type": "text", "value":""}]
	},
	Globals.EventTypes.SET_DIALOGUE_POSITION:{
		"label": "set_dialogue_position",
		"properties": [{"name":"dialogue_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.START_FIGHT_MENU:{
		"label": "start_fight_menu",
		"properties": [{"name":"npc_name","type": "text", "value":""}, {"name":"npc_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.SHOW_DIALOGUE_ANSWERS:{
		"label": "show_dialogue_answers",
		"properties": [{"name":"npc_name","type": "text", "value":""}, {"name":"npc_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.SET_TIMELINE_TIME:{
		"label": "set_timeline_time",
		"properties": [{"name":"npc_name","type": "text", "value":""}, {"name":"npc_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.JUMP_IF_ANSWER:{
		"label": "jump_if_answer",
		"properties": [{"name":"npc_name","type": "text", "value":""}, {"name":"npc_position","type": "Vector2", "value":Vector2.ZERO}]
	}
}

var index_to_event_type : Dictionary = {}

func _ready() -> void:
	create_lines()
	create_side_bar()

func _process(_delta: float) -> void:
	$HBoxContainer/SideBar.scroll_vertical = $HBoxContainer/TimeLineInner.scroll_vertical

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.double_click:
		add_event(event.position)

func add_event(_position : Vector2) -> void:
	var mposx_relative = _position.x - $HBoxContainer/TimeLineInner.position.x + $HBoxContainer/TimeLineInner.scroll_horizontal
	var line_index : int = int((_position.y - position.y + $HBoxContainer/TimeLineInner.scroll_vertical)/ LINE_H)
	if line_index < 0: return 
	var line : Container = $HBoxContainer/TimeLineInner/VBoxContainer.get_children()[line_index]
	var event : Event = event_scene.instantiate()
	event.id = id_increment
	id_increment += 1
	event.set_time(mposx_relative / 100)
	event.type = index_to_event_type[line_index]
	event.data = EVENT_DATA_FORM[event.type]['properties'].duplicate()
	Globals.event_just_created = true
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

func create_side_bar() -> void:
	var _i : int = 0
	for event in EVENT_DATA_FORM.values():
		var panel_template : Panel = $HBoxContainer/SideBar/VBoxContainer/Panel
		var new_panel = panel_template.duplicate()
		new_panel.visible = true
		new_panel.get_node("HBoxContainer/Label").text = event['label']
		$HBoxContainer/SideBar/VBoxContainer.add_child(new_panel)
		_i += 1
	$HBoxContainer/SideBar/VBoxContainer.custom_minimum_size.y = 6 * LINE_H + 5 * 5 + 10

func create_lines() -> void:
	var i : int = 0
	for event in EVENT_DATA_FORM.keys():
		var container : Container = Container.new()
		container.custom_minimum_size = Vector2(LINE_W, LINE_H)
		var panel : Panel = Panel.new()
		panel.custom_minimum_size = container.custom_minimum_size
		container.add_child(panel)
		$HBoxContainer/TimeLineInner/VBoxContainer.add_child(container)
		index_to_event_type[i] = event
		lines.append(container)
		i += 1
