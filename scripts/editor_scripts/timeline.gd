extends Control

var event_scene : PackedScene = preload("res://scenes/editor_scenes/event.tscn")

var id_increment = 0

const LINE_H  : int = 50
const  LINE_W : int = 2000

var zoom : float = 1
var offset : float = 0
var events : Array = []
var dragging : bool = false
var event_type_to_create = Globals.EventTypes.SPAWN_NPC
var lines : Array = []

var EVENT_DATA_FORM  : Dictionary = {
	Globals.EventTypes.SPAWN_PROYECTILE:{
		"label" : "spawn_proyectile",
		"properties": [{"name":"npc_position","type": "selector", "value":""}]
	},
	Globals.EventTypes.SPAWN_NPC:{
		"label": "spawn_npc",
		"properties": [{"name":"npc_name","type": "text", "value":""}, {"name":"npc_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.WRITE_DIALOGUE:{
		"label": "write_dialogue",
		"properties": [{"name":"dialogue_content","type": "text", "value":""}]
	},
	Globals.EventTypes.SET_DIALOGUE_POSITION:{
		"label": "set_dialogue_position",
		"properties": [{"name":"dialogue_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.CHANGE_ARENA:{
		'label':"change_area",
		"properties": [{"name":"arena_position","type": "Vector2", "value":Vector2.ZERO}, {"name":"arena_size","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.SET_PLAYER_POSITION:{
		"label": "set_player_position",
		"properties": [{"name":"player_position","type": "Vector2", "value":Vector2.ZERO}]
	},
	Globals.EventTypes.START_FIGHT_MENU:{
		"label": "start_fight_menu",
		"properties": []
	},
	Globals.EventTypes.SHOW_DIALOGUE_ANSWERS:{
		"label": "show_dialogue_answers",
		"properties": [{"name":"answers_options","type": "array", "value":[]}]
	},
	Globals.EventTypes.SET_TIMELINE_TIME:{
		"label": "set_timeline_time",
		"properties": [{"name":"time","type": "float", "value":0}]
	},
	Globals.EventTypes.JUMP_IF_ANSWER:{
		"label": "jump_if_answer",
		"properties": [{"name":"answer_id","type": "int", "value":0}]
	}
}

func _ready() -> void:
	$Background.visible = false
	create_lines()
	create_side_bar()

func _process(_delta: float) -> void:
	$HBoxContainer/SideBar.scroll_vertical = $HBoxContainer/TimeLineInner.scroll_vertical

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.double_click:
		add_event(event.position)

func add_event(_position : Vector2, _is_index : bool = false, _data = null) -> void:
	var time : float
	var line_index : int
	var data : Array

	if _is_index:
		line_index = int(_position.x)
		time = _position.y
		data = _data
	else:
		time = (_position.x - $HBoxContainer/TimeLineInner.position.x + $HBoxContainer/TimeLineInner.scroll_horizontal) / 100
		line_index = int((_position.y - position.y + $HBoxContainer/TimeLineInner.scroll_vertical)/ LINE_H)
		if line_index < 0: return
		data = EVENT_DATA_FORM[line_index]['properties']

	var event : Event = event_scene.instantiate()
	event.id = id_increment
	event.type = line_index as Globals.EventTypes
	event.set_time(time)
	event.set_data(data)
	
	var line : Container = $HBoxContainer/TimeLineInner/VBoxContainer.get_children()[line_index]
	line.add_child(event)
	events.append(event)
	
	id_increment += 1

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
	for event in EVENT_DATA_FORM.keys():
		var container : Container = Container.new()
		container.custom_minimum_size = Vector2(LINE_W, LINE_H)
		var panel : Panel = Panel.new()
		panel.custom_minimum_size = container.custom_minimum_size
		container.add_child(panel)
		$HBoxContainer/TimeLineInner/VBoxContainer.add_child(container)
		lines.append(container)
