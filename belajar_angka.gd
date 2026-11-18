extends Node2D

var angka = 1

@onready var gambar_angka = $ImgAngka
@onready var label_atas = $LabelAtas
@onready var label_bawah = $LabelBawah

@onready var btn_prev = $BtnSebelumnya
@onready var btn_next = $BtnSelanjutnya
@onready var btn_back = $BtnKembali
@onready var btn_audio = $BtnAudio


func _ready():
	update_tampilan()

	# Pivot di tengah tombol
	btn_prev.pivot_offset = btn_prev.size / 2
	btn_next.pivot_offset = btn_next.size / 2
	btn_back.pivot_offset = btn_back.size / 2
	btn_audio.pivot_offset = btn_audio.size / 2

	# Hover Sebelumnya
	btn_prev.mouse_entered.connect(_on_prev_entered)
	btn_prev.mouse_exited.connect(_on_prev_exited)

	# Hover Selanjutnya
	btn_next.mouse_entered.connect(_on_next_entered)
	btn_next.mouse_exited.connect(_on_next_exited)

	# Hover Kembali
	btn_back.mouse_entered.connect(_on_back_entered)
	btn_back.mouse_exited.connect(_on_back_exited)



func update_tampilan():

	var path = "res://assets/angka/angka%d.png" % angka

	if ResourceLoader.exists(path):
		gambar_angka.texture = load(path)

	label_atas.text = "Ini Angka %d" % angka
	label_bawah.text = "Dibaca \"%s\"" % ubah_ke_teks(angka).to_upper()


# ====================
# HOVER SEBELUMNYA
# ====================

func _on_prev_entered():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_prev, "scale", Vector2(1.03, 1.03), 0.15)

func _on_prev_exited():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_prev, "scale", Vector2.ONE, 0.15)


# ====================
# HOVER SELANJUTNYA
# ====================

func _on_next_entered():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_next, "scale", Vector2(1.03, 1.03), 0.15)

func _on_next_exited():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn_next, "scale", Vector2.ONE, 0.15)


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
# HOVER AUDIO
# ====================



# ====================
# TOMBOL AUDIO
# ====================

func _on_BtnAudio_pressed():

	AudioManager.play_click()

	AudioManager.play_number(angka)


# ====================
# TOMBOL SELANJUTNYA
# ====================

func _on_BtnSelanjutnya_pressed():
	AudioManager.play_click()

	# Hentikan suara angka yang sedang diputar
	AudioManager.number_player.stop()

	if angka < 10:
		angka += 1
		update_tampilan()


# ====================
# TOMBOL SEBELUMNYA
# ====================

func _on_BtnSebelumnya_pressed():
	AudioManager.play_click()

	# Hentikan suara angka yang sedang diputar
	AudioManager.number_player.stop()

	if angka > 1:
		angka -= 1
		update_tampilan()

# ====================
# TOMBOL KEMBALI
# ====================

func _on_BtnKembali_pressed():
	AudioManager.play_click()

	AudioManager.number_player.stop()

	get_tree().change_scene_to_file("res://mengenal_angka.tscn")


# ====================
# ANGKA KE TEKS
# ====================

func ubah_ke_teks(a):
	match a:
		1: return "satu"
		2: return "dua"
		3: return "tiga"
		4: return "empat"
		5: return "lima"
		6: return "enam"
		7: return "tujuh"
		8: return "delapan"
		9: return "sembilan"
		10: return "sepuluh"
		_: return ""
