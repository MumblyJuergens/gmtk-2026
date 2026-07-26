extends Node

@export var audio_streams: Array[AudioStream] = []

@onready var _audio_stream_players: Array[AudioStreamPlayer] = [
	$AudioStreamPlayer0,
	$AudioStreamPlayer1,
	$AudioStreamPlayer2,
	$AudioStreamPlayer3,
]

@onready var _audio_stream_player_music: AudioStreamPlayer = $AudioStreamPlayerMusic


func play(stream_index: int) -> void:
	var player: AudioStreamPlayer = _audio_stream_players.pop_front()
	if not player:
		return

	player.stream = audio_streams[stream_index]
	player.finished.connect(func() -> void: _audio_stream_players.push_back(player))
	player.play()


func play_music() -> void:
	_audio_stream_player_music.play()
	_audio_stream_player_music.finished.connect(_audio_stream_player_music.play)


func stop_music() -> void:
	_audio_stream_player_music.stop()
