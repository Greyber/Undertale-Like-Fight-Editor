extends Node2D

enum States {
	RUNNING,
	WAITING,
	MENU
}

var timeline : FightData
var original_timeline : FightData
var time  : float = 0
var state : States = States.RUNNING

func _ready() -> void:
	EventManager.CONTINUE_TIMELINE.connect(_run)
	
func set_timeline(new_timeline: FightData) -> void:
	timeline = new_timeline
	original_timeline = new_timeline.duplicate()
	sort_timeline()
	
func sort_timeline() -> void:
	timeline.data.sort_custom(func(a, b): return a['time'] < b['time'])

func _process(delta: float) -> void:
	if state == States.RUNNING:
		time+= delta
		_evaluate_timeline_at(time)
	elif state == States.WAITING:
		pass
	elif state == States.MENU:
		$FightMenu.enable()
		_pause()

func _evaluate_timeline_at(t:float) -> void:
	for event in timeline.data.duplicate():
		if t < event['time']: return
		match event['type']:
			Globals.EventTypes.SPAWN_NPC:
				$FightCharacterManager.spawn_npc(event['npc_name'])
				$FightCharacterManager.move_npc(event['npc_position'])
			Globals.EventTypes.SPAWN_PROYECTILE:
				$FightProyectileManager.spawn_proyectile(event)
			Globals.EventTypes.CHANGE_ARENA:
				$FightArenaManager.set_arena_size(event['arena_size'])
				$FightArenaManager.set_arena_position(event['arena_position'])
			Globals.EventTypes.SET_PLAYER_POSITION:
				Globals.player.set_global_position(event['player_position'])
				Globals.player.visible = true
			Globals.EventTypes.WRITE_DIALOGUE:
				$TextRenderer.start_writing(event['dialogue_content'])
			Globals.EventTypes.SET_DIALOGUE_POSITION:
				$TextRenderer.set_text_position(event['dialogue_position'])
			Globals.EventTypes.START_FIGHT_MENU:
				$FightMenu.enable_action_buttons()
				_pause()
			Globals.EventTypes.SHOW_DIALOGUE_ANSWERS:
				$FightMenu.enable_answer_buttons(event['answers'])
				_pause()
			Globals.EventTypes.SET_TIMELINE_TIME:
				time = event['time']
			Globals.EventTypes.JUMP_IF_ANSWER:
				if $FightMenu.pressed_answer_button_id == event['answer_id']:
					time = event['new_time']
		timeline.data.erase(event)
			
func _pause() -> void:
	state = States.WAITING

func _run():
	state = States.RUNNING
