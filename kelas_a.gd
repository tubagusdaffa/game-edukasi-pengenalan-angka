extends Node2D

@onready var btn_belajar = $BtnBelajar
@onready var btn_back = $BtnBack


func _ready():
	# Pivot di tengah tombol
	btn_belajar.pivot_offset = btn_belajar.size / 2
	btn_back.pivot_offset = btn_back.size / 2

	# Hover Belajar
	btn_belajar.mouse_entered.connect(_on_belajar_entered)
	btn_belajar.mouse_exited.connect(_on_belajar_exited)

	# Hover Kembali
	btn_back.mouse_entered.connect(_on_back_entered)
	btn_back.mouse_exited.connect(_on_back_exited)


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
# HOVER KEMBALI
# ====================

func _on_back_entered():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_back, "scale", Vector2(1.03, 1.03), 0.15)

func _on_back_exited():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_back, "scale", Vector2.ONE, 0.15)


# ====================
# TOMBOL
# ====================

func _on_btn_belajar_pressed():
	AudioManager.play_click()
	print("Masuk Mode Belajar")
	get_tree().change_scene_to_file("res://mengenal_angka.tscn")


func _on_btn_back_pressed():
	AudioManager.play_click()
	print("Kembali ke Pilih Kelas")
	get_tree().change_scene_to_file("res://pilih_kelas.tscn")
