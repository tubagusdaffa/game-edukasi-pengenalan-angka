extends Control

var jawaban_benar = 0
var sudah_jawab = false

var skor = 0
var soal_ke = 1
var total_soal = 10

var jumlah_kiri = 0
var jumlah_kanan = 0

var nilai_card1 = 0
var nilai_card2 = 0
var nilai_card3 = 0

var hewan_aktif = ""

var daftar_hewan = ["ayam","bebek","katak","kura","ikan"]

var texture_hewan = {
	"ayam": preload("res://assets/ayam.png"),
	"bebek": preload("res://assets/bebek.png"),
	"katak": preload("res://assets/katak.png"),
	"kura": preload("res://assets/kura.png"),
	"ikan": preload("res://assets/ikan.png")
}

var kalimat_soal = [
	"Bantu aku menghitung %s ya!",
	"Ayo hitung %s bersama!",
	"Ada berapa %s semuanya?",
	"Yuk hitung %s ini!",
	"Coba hitung %s ya!"
]

var pesan_benar = [
	"Hebat sekali! 🎉",
	"Jawabanmu benar! ⭐",
	"Pintar! 😄",
	"Luar biasa! 👏",
	"Kamu hebat!"
]

var pesan_salah = [
	"Yuk hitung lagi 😊",
	"Coba sekali lagi ya!",
	"Hampir benar 😄",
	"Semangat!",
	"Ayo coba lagi!"
]

@onready var label_instruksi = $PanelInstruksi/LabelInstruksi

@onready var singa = $Singa

@onready var card1 = $Card1
@onready var card2 = $Card2
@onready var card3 = $Card3

@onready var btn_back = $BtnKembali

@onready var label_soal = $UI/LabelSoal
@onready var label_skor = $UI/LabelSkor
@onready var progress_bar = $UI/ProgressBar

@onready var popup_hasil = $PopupHasil
@onready var label_hasil_skor = $PopupHasil/PanelHasil/Isi/LabelSkor
@onready var label_pesan = $PopupHasil/PanelHasil/Isi/LabelPesan
@onready var btn_main_lagi = $PopupHasil/PanelHasil/Isi/BtnMainLagi
@onready var btn_menu = $PopupHasil/PanelHasil/Isi/BtnMenu

@onready var hewan_kiri = $HewanKiri
@onready var hewan_kanan = $HewanKanan


func _ready():

	randomize()

	popup_hasil.visible = false

	card1.pivot_offset = card1.size / 2
	card2.pivot_offset = card2.size / 2
	card3.pivot_offset = card3.size / 2
	btn_back.pivot_offset = btn_back.size / 2
	

	card1.mouse_entered.connect(func(): hover_masuk(card1))
	card1.mouse_exited.connect(func(): hover_keluar(card1))

	card2.mouse_entered.connect(func(): hover_masuk(card2))
	card2.mouse_exited.connect(func(): hover_keluar(card2))

	card3.mouse_entered.connect(func(): hover_masuk(card3))
	card3.mouse_exited.connect(func(): hover_keluar(card3))

	btn_back.mouse_entered.connect(func(): hover_masuk(btn_back))
	btn_back.mouse_exited.connect(func(): hover_keluar(btn_back))

	btn_main_lagi.pressed.connect(_on_btn_main_lagi_pressed)
	btn_menu.pressed.connect(_on_btn_menu_pressed)
	
	generate_soal()
	update_ui()


func update_ui():

	label_soal.text = "Soal %d / %d" % [soal_ke, total_soal]
	label_skor.text = "Skor : %d" % skor

	if soal_ke >= total_soal:
		progress_bar.value = 100
	else:
		progress_bar.value = float(soal_ke - 1) / total_soal * 100
		
func tampilkan_hasil():

	popup_hasil.visible = true

	label_hasil_skor.text = "Skor : %d" % skor

	if skor == 100:
		label_pesan.text = "🌟 Luar Biasa!"
	elif skor >= 80:
		label_pesan.text = "😊 Kamu Hebat!"
	elif skor >= 60:
		label_pesan.text = "👍 Bagus!"
	else:
		label_pesan.text = "💪 Ayo semangat!"

# ===================================================
# GENERATE SOAL
# ===================================================

func generate_soal():

	sudah_jawab = false

	hewan_aktif = daftar_hewan.pick_random()

	jumlah_kiri = randi_range(1,4)
	jumlah_kanan = randi_range(1,4)

	while jumlah_kiri + jumlah_kanan > 8:
		jumlah_kiri = randi_range(1,4)
		jumlah_kanan = randi_range(1,4)

	jawaban_benar = jumlah_kiri + jumlah_kanan

	label_instruksi.text = kalimat_soal.pick_random() % nama_hewan()

	animasi_label()

	tampilkan_hewan_soal()

	var pilihan = []

	pilihan.append(jawaban_benar)

	while pilihan.size() < 3:

		var salah = randi_range(1,8)

		if !pilihan.has(salah):
			pilihan.append(salah)

	pilihan.shuffle()

	nilai_card1 = pilihan[0]
	nilai_card2 = pilihan[1]
	nilai_card3 = pilihan[2]

	tampilkan_card(card1.get_node("GridJawaban"),nilai_card1)
	tampilkan_card(card2.get_node("GridJawaban"),nilai_card2)
	tampilkan_card(card3.get_node("GridJawaban"),nilai_card3)



# ===================================================
# TAMPILKAN SOAL
# ===================================================

func tampilkan_hewan_soal():

	var tex = texture_hewan[hewan_aktif]

	var jumlah_tampil_kiri = 0
	var jumlah_tampil_kanan = 0

	for i in range(5):

		var kiri = hewan_kiri.get_node("Hewan%d" % (i + 1))
		var kanan = hewan_kanan.get_node("Hewan%d" % (i + 1))

		kiri.texture = tex
		kanan.texture = tex

		kiri.visible = i < jumlah_kiri
		kanan.visible = i < jumlah_kanan

		if kiri.visible:
			jumlah_tampil_kiri += 1

		if kanan.visible:
			jumlah_tampil_kanan += 1

	# Paksa HBox mengecil sesuai isi
	hewan_kiri.custom_minimum_size.x = jumlah_tampil_kiri * 60
	hewan_kanan.custom_minimum_size.x = jumlah_tampil_kanan * 60

# ===================================================
# TAMPILKAN CARD
# ===================================================

func tampilkan_card(grid, jumlah):

	var tex = texture_hewan[hewan_aktif]

	for i in range(8):

		var node = grid.get_node("Hewan%d" % (i + 1))

		node.texture = tex
		node.visible = i < jumlah

		node.scale = Vector2(0.75,0.75)

	# Paksa Grid update
	grid.queue_sort()

	# Hitung jumlah kolom
	var kolom = min(jumlah,4)

	# Geser supaya tetap di tengah
	var ukuran = 52.0
	var lebar = kolom * ukuran

	grid.columns = min(jumlah,4)

	grid.custom_minimum_size.x = min(jumlah,4) * 55

	grid.queue_sort()
	

# ===================================================
# NAMA HEWAN
# ===================================================

func nama_hewan():

	match hewan_aktif:

		"ayam":
			return "anak ayam"

		"bebek":
			return "bebek"

		"katak":
			return "katak"

		"kura":
			return "kura-kura"

		"ikan":
			return "ikan"

	return ""
	
# ===================================================
# CEK JAWABAN
# ===================================================

func cek_jawaban(nilai):

	if sudah_jawab:
		return

	if nilai == jawaban_benar:

		sudah_jawab = true

		skor += 10

		AudioManager.play_correct()

		label_instruksi.text = "%s Ada %d %s semuanya!" % [
			pesan_benar.pick_random(),
			jawaban_benar,
			nama_hewan()
		]

		update_ui()
		animasi_label()
		animasi_singa_senang()

		await get_tree().create_timer(1.3).timeout

		# Kalau sudah soal terakhir
		if soal_ke >= total_soal:

			progress_bar.value = 100
			tampilkan_hasil()
			return

		# Lanjut ke soal berikutnya
		soal_ke += 1
		update_ui()
		generate_soal()

	else:

		AudioManager.play_wrong()

		label_instruksi.text = "%s Yuk hitung lagi." % pesan_salah.pick_random()

		animasi_label()
		animasi_singa_sedih()

		await get_tree().create_timer(1.3).timeout

		# Kalau sudah soal terakhir
		if soal_ke >= total_soal:

			progress_bar.value = 100
			tampilkan_hasil()
			return

		# Lanjut ke soal berikutnya
		soal_ke += 1
		update_ui()
		generate_soal()


# ===================================================
# HOVER
# ===================================================

func hover_masuk(btn):

	var tween = create_tween()

	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		btn,
		"scale",
		Vector2(1.08,1.08),
		0.20
	)


func hover_keluar(btn):

	var tween = create_tween()

	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		btn,
		"scale",
		Vector2.ONE,
		0.18
	)



# ===================================================
# ANIMASI LABEL
# ===================================================

func animasi_label():

	label_instruksi.scale = Vector2(0.90,0.90)
	label_instruksi.modulate.a = 0.0

	var tween = create_tween()

	tween.set_parallel(true)

	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		label_instruksi,
		"scale",
		Vector2.ONE,
		0.25
	)

	tween.tween_property(
		label_instruksi,
		"modulate:a",
		1.0,
		0.25
	)



# ===================================================
# ANIMASI SINGA BENAR
# ===================================================

func animasi_singa_senang():

	var pos = singa.position

	var tween = create_tween()

	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		singa,
		"position:y",
		pos.y - 12,
		0.18
	)

	tween.parallel().tween_property(
		singa,
		"scale",
		Vector2(1.08,1.08),
		0.18
	)

	tween.set_trans(Tween.TRANS_BOUNCE)

	tween.tween_property(
		singa,
		"position:y",
		pos.y,
		0.28
	)

	tween.parallel().tween_property(
		singa,
		"scale",
		Vector2.ONE,
		0.28
	)



# ===================================================
# ANIMASI SINGA SALAH
# ===================================================

func animasi_singa_sedih():

	var tween = create_tween()

	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		singa,
		"rotation_degrees",
		6,
		0.08
	)

	tween.tween_property(
		singa,
		"rotation_degrees",
		-6,
		0.08
	)

	tween.tween_property(
		singa,
		"rotation_degrees",
		4,
		0.08
	)

	tween.tween_property(
		singa,
		"rotation_degrees",
		0,
		0.08
	)



# ===================================================
# CARD
# ===================================================

func _on_Card1_pressed():
	cek_jawaban(nilai_card1)


func _on_Card2_pressed():
	cek_jawaban(nilai_card2)


func _on_Card3_pressed():
	cek_jawaban(nilai_card3)

func _on_btn_main_lagi_pressed():

	get_tree().reload_current_scene()


func _on_btn_menu_pressed():

	get_tree().change_scene_to_file("res://kelas_b.tscn")


# ===================================================
# KEMBALI
# ===================================================

func _on_BtnKembali_pressed():

	AudioManager.play_click()

	get_tree().change_scene_to_file("res://kelas_b.tscn")  
