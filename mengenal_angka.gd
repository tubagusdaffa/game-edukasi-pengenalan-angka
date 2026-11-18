extends Node2D

@onready var btn_belajar = $Buttonbelajar
@onready var btn_game = $Buttongame
@onready var btn_kembali = $Buttonkembali


func _ready():
	# Pivot di tengah tombol
	btn_belajar.pivot_offset = btn_belajar.size / 2
	btn_game.pivot_offset = btn_game.size / 2
	btn_kembali.pivot_offset = btn_kembali.size / 2

	# Hover Belajar
	btn_belajar.mouse_entered.connect(_on_belajar_entered)
	btn_belajar.mouse_exited.connect(_on_belajar_exited)

	# Hover Game
	btn_game.mouse_entered.connect(_on_game_entered)
	btn_game.mouse_exited.connect(_on_game_exited)

	# Hover Kembali
	btn_kembali.mouse_entered.connect(_on_kembali_entered)
	btn_kembali.mouse_exited.connect(_on_kembali_exited)


# ====================
# HOVER BELAJAR
# ====================

func _on_belajar_entered():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_belajar, "scale", Vector2(1.03, 1.03), 0.15)

func _on_belajar_exited():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_belajar, "scale", Vector2.ONE, 0.15)


# ====================
# HOVER GAME
# ====================

func _on_game_entered():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_game, "scale", Vector2(1.03, 1.03), 0.15)

func _on_game_exited():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_game, "scale", Vector2.ONE, 0.15)


# ====================
# HOVER KEMBALI
# ====================

func _on_kembali_entered():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_kembali, "scale", Vector2(1.03, 1.03), 0.15)

func _on_kembali_exited():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_kembali, "scale", Vector2.ONE, 0.15)


# ====================
# TOMBOL
# ====================

func _on_button_belajar_pressed():
	AudioManager.play_click()
	get_tree().change_scene_to_file("res://belajar_angka.tscn")


func _on_button_game_pressed():
	AudioManager.play_click()
	get_tree().change_scene_to_file("res://game_angka.tscn")


func _on_button_kembali_pressed():
	AudioManager.play_click()
	get_tree().change_scene_to_file("res://kelas_a.tscn")
