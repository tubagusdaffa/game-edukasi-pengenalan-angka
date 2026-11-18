extends Control

@onready var btn_kelas_a = $BtnKelasA
@onready var btn_kelas_b = $BtnKelasB
@onready var btn_back = $BtnBack


func _ready():
	# Pivot di tengah tombol
	btn_kelas_a.pivot_offset = btn_kelas_a.size / 2
	btn_kelas_b.pivot_offset = btn_kelas_b.size / 2
	btn_back.pivot_offset = btn_back.size / 2

	# Hover Kelas A
	btn_kelas_a.mouse_entered.connect(_on_kelas_a_entered)
	btn_kelas_a.mouse_exited.connect(_on_kelas_a_exited)

	# Hover Kelas B
	btn_kelas_b.mouse_entered.connect(_on_kelas_b_entered)
	btn_kelas_b.mouse_exited.connect(_on_kelas_b_exited)

	# Hover Kembali
	btn_back.mouse_entered.connect(_on_back_entered)
	btn_back.mouse_exited.connect(_on_back_exited)


# ====================
# HOVER KELAS A
# ====================

func _on_kelas_a_entered():
	var tween = create_tween()
	tween.tween_property(btn_kelas_a, "scale", Vector2(1.05, 1.05), 0.15)

func _on_kelas_a_exited():
	var tween = create_tween()
	tween.tween_property(btn_kelas_a, "scale", Vector2(1.0, 1.0), 0.15)


# ====================
# HOVER KELAS B
# ====================

func _on_kelas_b_entered():
	var tween = create_tween()
	tween.tween_property(btn_kelas_b, "scale", Vector2(1.05, 1.05), 0.15)

func _on_kelas_b_exited():
	var tween = create_tween()
	tween.tween_property(btn_kelas_b, "scale", Vector2(1.0, 1.0), 0.15)


# ====================
# HOVER KEMBALI
# ====================

func _on_back_entered():
	var tween = create_tween()
	tween.tween_property(btn_back, "scale", Vector2(1.03, 1.03), 0.15)

func _on_back_exited():
	var tween = create_tween()
	tween.tween_property(btn_back, "scale", Vector2(1.0, 1.0), 0.15)


# ====================
# TOMBOL
# ====================

func _on_btn_kelas_a_pressed():
	AudioManager.play_click()
	print("Masuk Kelas A")
	get_tree().change_scene_to_file("res://kelas_a.tscn")


func _on_BtnKelasB_pressed():
	AudioManager.play_click()
	print("Kelas B dipilih")
	get_tree().change_scene_to_file("res://kelas_b.tscn")


func _on_BtnBack_pressed():
	AudioManager.play_click()
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_button_kelas_a_pressed() -> void:
	pass


func _on_button_kelas_b_pressed() -> void:
	pass
