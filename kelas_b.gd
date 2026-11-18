extends Control

@onready var btn_game = $BtnGameBerhitung
@onready var btn_kembali = $BtnKembali


func _ready():
	print("Masuk Kelas B")

	# Pivot di tengah
	btn_game.pivot_offset = btn_game.size / 2
	btn_kembali.pivot_offset = btn_kembali.size / 2

	# Hover Game Berhitung
	btn_game.mouse_entered.connect(_on_game_entered)
	btn_game.mouse_exited.connect(_on_game_exited)

	# Hover Kembali
	btn_kembali.mouse_entered.connect(_on_kembali_entered)
	btn_kembali.mouse_exited.connect(_on_kembali_exited)


# ====================
# HOVER GAME BERHITUNG
# ====================

func _on_game_entered():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		btn_game,
		"scale",
		Vector2(1.05, 1.05),
		0.15
	)

func _on_game_exited():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		btn_game,
		"scale",
		Vector2.ONE,
		0.15
	)


# ====================
# HOVER KEMBALI
# ====================

func _on_kembali_entered():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		btn_kembali,
		"scale",
		Vector2(1.03, 1.03),
		0.15
	)

func _on_kembali_exited():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		btn_kembali,
		"scale",
		Vector2.ONE,
		0.15
	)


# ====================
# TOMBOL
# ====================

func _on_btn_game_berhitung_pressed():
	AudioManager.play_click()
	get_tree().change_scene_to_file("res://game_berhitung_dasar.tscn")


func _on_btn_kembali_pressed():
	AudioManager.play_click()
	get_tree().change_scene_to_file("res://pilih_kelas.tscn")
