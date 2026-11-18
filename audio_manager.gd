extends Node

var click_player: AudioStreamPlayer
var correct_player: AudioStreamPlayer
var wrong_player: AudioStreamPlayer
var number_player: AudioStreamPlayer

func _ready():

	# =========================
	# CLICK
	# =========================
	click_player = AudioStreamPlayer.new()
	add_child(click_player)
	click_player.stream = preload("res://audio/click.wav")
	click_player.volume_db = -1

	# =========================
	# CORRECT
	# =========================
	correct_player = AudioStreamPlayer.new()
	add_child(correct_player)
	correct_player.stream = preload("res://audio/correct.wav")
	correct_player.volume_db = -10

	# =========================
	# WRONG
	# =========================
	wrong_player = AudioStreamPlayer.new()
	add_child(wrong_player)
	wrong_player.stream = preload("res://audio/wrong.wav")
	wrong_player.volume_db = -10

	# =========================
	# ANGKA 1-10
	# =========================
	number_player = AudioStreamPlayer.new()
	add_child(number_player)
	number_player.volume_db = -8


# =========================
# CLICK
# =========================

func play_click():
	click_player.stop()
	click_player.play()


# =========================
# BENAR
# =========================

func play_correct():
	correct_player.stop()
	correct_player.seek(0.0)
	correct_player.play()


# =========================
# SALAH
# =========================

func play_wrong():
	wrong_player.stop()
	wrong_player.seek(0.0)
	wrong_player.play()


# =========================
# SUARA ANGKA
# =========================

func play_number(number:int):

	number_player.stop()

	var path = "res://audio/%d.wav" % number

	if ResourceLoader.exists(path):

		number_player.stream = load(path)

		number_player.play()

	else:

		print("Audio tidak ditemukan: ", path)
