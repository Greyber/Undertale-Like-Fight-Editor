extends Node2D

# timeline = [{'type':'invoque', 'time':0.1, 'entity':'proyectile'}, {'type':'spawn_npc', 'npc_name':'pablo'}]
enum States {
	RUNNING,
	WAITING,
	MENU
}

var timeline :Array = []
var time  : float = 0
var state : States = States.RUNNING

func _ready() -> void:
	EventManager.CONTINUE_TIMELINE.connect(run)
	
func set_timeline(new_timeline: Array) -> void:
	timeline = new_timeline
	sort_timeline()
	
func sort_timeline() -> void:
	timeline.sort_custom(func(a, b): return a['time'] < b['time'])

func _process(delta: float) -> void:
	update_timeline(delta)

func update_timeline(delta) -> void :
	if state == States.RUNNING:
		time += delta
		for event in timeline.duplicate():
			if time < event['time']: return
			match event['type']:
				Globals.EventTypes.SPAWN_NPC:
					$FightCharacterManager.spawn_npc(event['npc_name'])
					$FightCharacterManager.move_npc(event['position'])
				Globals.EventTypes.SPAWN_PROYECTILE:
					PoolManager.request_queue(event['entity'])
				Globals.EventTypes.PAUSE:
					pass
				Globals.EventTypes.MENU:
					pass
				Globals.EventTypes.CHANGE_ARENA:
					$FightArenaManager.set_arena_size(event['size'])
					$FightArenaManager.set_arena_position(event['position'])
				Globals.EventTypes.SET_PLAYER_POSITION:
					Globals.player.set_global_position(event['position'])
					Globals.player.visible = true
				Globals.EventTypes.WRITE_DIALOGUE:
					$TextRenderer.start_writing(event['text'])
				Globals.EventTypes.SET_DIALOGUE_POSITION:
					$TextRenderer.set_text_position(event['position'])
				Globals.EventTypes.PAUSE:
					pause()
				Globals.EventTypes.START_FIGHT_MENU:
					$FightMenu.enable_action_buttons()
					pause()
				Globals.EventTypes.SHOW_DIALOGUE_ANSWERS:
					$FightMenu.enable_answer_buttons(event['answers'])
					pause()
				Globals.EventTypes.SET_TIMELINE_TIME:
					time = event['time']
				Globals.EventTypes.JUMP_IF_ANSWER:
					if $FightMenu.pressed_answer_button_id == event['answer_id']:
						time = event['new_time']
					
			timeline.erase(event)
			
	elif state == States.WAITING:
		pass
		
	elif state == States.MENU:
		$FightMenu.enable()
		pause()
		
func pause() -> void:
	state = States.WAITING

func run():
	state = States.RUNNING
