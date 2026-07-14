extends SubViewport


var arena_manager
var character_manager

func _ready() -> void:
	arena_manager = $FightArenaManager
	character_manager = $FightCharacterManager
	EventManager.ON_SELECTED_EVENT_EDITOR.connect(_on_selected_event)

func _on_selected_event(_event):
	if _event.type == Globals.EventTypes.CHANGE_ARENA:
		arena_manager.set_instant(_event.data[0]['value'], _event.data[1]['value'])
	elif _event.type == Globals.EventTypes.SPAWN_NPC:
		character_manager.set_instant(_event.data[0]['value'], _event.data[1]['value'])
