extends Node

var bgm_player: AudioStreamPlayer

func _ready():

	bgm_player = AudioStreamPlayer.new()

	add_child(bgm_player)

	bgm_player.volume_db = -20

	bgm_player.stream = preload("res://audio/anak_nusantara115-bright-ukulele-amp-claps-positive-background-music-306705.mp3")

	bgm_player.play()
