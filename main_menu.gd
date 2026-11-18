extends Control

@onready var btn_mulai = $ButtonMulai
@onready var btn_keluar = $ButtonKeluar


func _ready():
	# Pivot di tengah tombol
	btn_mulai.pivot_offset = btn_mulai.size / 2
	btn_keluar.pivot_offset = btn_keluar.size / 2

	# Hover tombol mulai
	btn_mulai.mouse_entered.connect(_on_mulai_entered)
	btn_mulai.mouse_exited.connect(_on_mulai_exited)

	# Hover tombol keluar
	btn_keluar.mouse_entered.connect(_on_keluar_entered)
	btn_keluar.mouse_exited.connect(_on_keluar_exited)


# ====================
# HOVER MULAI
# ====================

func _on_mulai_entered():
	var tween = create_tween()
	tween.tween_property(btn_mulai, "scale", Vector2(1.1, 1.1), 0.15)

func _on_mulai_exited():
	var tween = create_tween()
	tween.tween_property(btn_mulai, "scale", Vector2(1.0, 1.0), 0.15)


# ====================
# HOVER KELUAR
# ====================

func _on_keluar_entered():
	var tween = create_tween()
	tween.tween_property(btn_keluar, "scale", Vector2(1.05, 1.05), 0.15)

func _on_keluar_exited():
	var tween = create_tween()
	tween.tween_property(btn_keluar, "scale", Vector2(1.0, 1.0), 0.15)


# ====================
# TOMBOL
# ====================

func _on_button_mulai_pressed():

	AudioManager.play_click()

	get_tree().change_scene_to_file("res://pilih_kelas.tscn")


func _on_button_keluar_pressed():

	AudioManager.play_click()

	get_tree().quit()
