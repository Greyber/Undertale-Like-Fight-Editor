extends Node

const POOL_SIZE : int = 5
const MUSIC_BUS_ID : String = "Music"
const SFX_BUS_ID : String = "SFX"

@export var tracks : AudioTable

var effects_pool : Node2D
var music_player : AudioStreamPlayer
var sfx_players : Array[AudioStreamPlayer] = []
var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var fade_duration : float = 1.0
var base_music_db : float = 0.0
var music_tween : Tween

var current_track : int = 0

func _ready() -> void:
	_setup_nodes()
	_setup_player_pool()

func _setup_nodes() -> void:
	effects_pool = Node2D.new()
	
	music_player = AudioStreamPlayer.new()
	music_player.bus = MUSIC_BUS_ID
	
	add_child(effects_pool)
	add_child(music_player)

func _setup_player_pool() -> void:
	for _i : int in range(0, POOL_SIZE):
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		effects_pool.add_child(player)
		sfx_players.append(player)
		
func player_music(setting: AudioSetting, with_fade : bool = true) -> void:
	if music_tween:
		music_tween.kill()
		
	music_player.stream = setting.source
	music_player.volume_db = -80.0
	music_player.play()
	
	if with_fade:
		music_tween = create_tween()
		music_tween.tween_property(music_player, "volume_db", setting.volume_db, fade_duration)
		music_tween.set_trans(Tween.TRANS_SINE)
	else:
		music_player.volume_db = setting.volume_db

func stop_music() -> void:
	if music_tween:
		music_tween.kill()
		
	music_tween = create_tween()
	music_tween.tween_property(music_player, "volume_db", -80.0, fade_duration)
	music_tween.set_trans(Tween.TRANS_SINE)
	music_tween.finished.connect(func() -> void: music_player.stop())
