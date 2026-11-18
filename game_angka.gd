extends Node2D

var jawaban_benar = 0
var sudah_jawab = false

var skor = 0
var soal_ke = 1
var total_soal = 10

var daftar_soal = []

var pesan_benar = [
	"Hebat! 🎉",
	"Pintar sekali! ⭐",
	"Kamu benar! 😊",
	"Luar biasa! 🎊",
	"Kerja bagus! 👏"
]

var pesan_salah = [
	"Ups... coba lagi ya 😊",
	"Hampir benar 😄",
	"Semangat! 💪",
	"Yuk dicoba lagi!",
	"Kamu pasti bisa! 🌟"
]

var nama_angka = {
	1: "satu",
	2: "dua",
	3: "tiga",
	4: "empat",
	5: "lima",
	6: "enam",
	7: "tujuh",
	8: "delapan",
	9: "sembilan",
	10: "sepuluh"
}

var kalimat_instruksi = [
	"Mana angka %s?",
	"Cari angka %s!",
	"Pilih angka %s!",
	"Sentuh angka %s!",
	"Temukan angka %s!",
	"Ayo cari %s!",
	"Yang mana %s?",
	"Tunjukkan %s!",
	"Klik angka %s!",
	"Ayo pilih %s!"
]

var nilai_card1 = 0
var nilai_card2 = 0
var nilai_card3 = 0

@onready var label_instruksi = $PanelInstruksi/LabelInstruksi

@onready var card1 = $Card1
@onready var card2 = $Card2
@onready var card3 = $Card3

@onready var img1 = $Card1/ImgAngka
@onready var img2 = $Card2/ImgAngka
@onready var img3 = $Card3/ImgAngka

@onready var btn_back = $BtnKembali
@onready var kelinci = $Kelinci

@onready var label_soal = $UI/LabelSoal
@onready var label_skor = $UI/LabelSkor
@onready var progress_bar = $UI/ProgressBar

@onready var popup_hasil = $PopupHasil
@onready var label_hasil_skor = $PopupHasil/PanelHasil/Isi/LabelSkor
@onready var label_pesan = $PopupHasil/PanelHasil/Isi/LabelPesan
@onready var btn_main_lagi = $PopupHasil/PanelHasil/Isi/BtnMainLagi
@onready var btn_menu = $PopupHasil/PanelHasil/Isi/BtnMenu

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
	
	daftar_soal = [1,2,3,4,5,6,7,8,9,10]
	daftar_soal.shuffle()
	update_ui()
	generate_soal()


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


func generate_soal():

	sudah_jawab = false

	jawaban_benar = daftar_soal[soal_ke - 1]

	label_instruksi.text = kalimat_instruksi.pick_random() % nama_angka[jawaban_benar]
	animasi_label()

	var pilihan = [jawaban_benar]

	while pilihan.size() < 3:
		var angka = randi() % 10 + 1

		if !pilihan.has(angka):
			pilihan.append(angka)

	pilihan.shuffle()

	nilai_card1 = pilihan[0]
	nilai_card2 = pilihan[1]
	nilai_card3 = pilihan[2]

	img1.texture = load("res://assets/angka/angka%d.png" % nilai_card1)
	img2.texture = load("res://assets/angka/angka%d.png" % nilai_card2)
	img3.texture = load("res://assets/angka/angka%d.png" % nilai_card3)


func cek_jawaban(pilihan):

	if sudah_jawab:
		return

	if pilihan == jawaban_benar:

		sudah_jawab = true

		skor += 10
		AudioManager.play_correct()

		label_instruksi.text = pesan_benar.pick_random()

		update_ui()
		animasi_label()
		animasi_kelinci_senang()

		await get_tree().create_timer(1.2).timeout

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

		label_instruksi.text = pesan_salah.pick_random()

		animasi_label()
		animasi_kelinci_sedih()

		await get_tree().create_timer(1.2).timeout

		# Kalau sudah soal terakhir
		if soal_ke >= total_soal:

			progress_bar.value = 100

			tampilkan_hasil()

			return

		# Lanjut ke soal berikutnya
		soal_ke += 1
		update_ui()
		generate_soal()



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

func animasi_label():

	label_instruksi.scale = Vector2(0.92,0.92)
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


func animasi_kelinci_senang():

	var tween = create_tween()

	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		kelinci,
		"position:y",
		kelinci.position.y - 12,
		0.18
	)

	tween.parallel().tween_property(
		kelinci,
		"scale",
		Vector2(1.08,1.08),
		0.18
	)

	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		kelinci,
		"position:y",
		kelinci.position.y,
		0.28
	)

	tween.parallel().tween_property(
		kelinci,
		"scale",
		Vector2.ONE,
		0.28
	)


func animasi_kelinci_sedih():

	var tween = create_tween()

	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		kelinci,
		"rotation_degrees",
		6,
		0.08
	)

	tween.tween_property(
		kelinci,
		"rotation_degrees",
		-6,
		0.08
	)

	tween.tween_property(
		kelinci,
		"rotation_degrees",
		4,
		0.08
	)

	tween.tween_property(
		kelinci,
		"rotation_degrees",
		0,
		0.08
	)


func _on_Card1_pressed():
	cek_jawaban(nilai_card1)


func _on_Card2_pressed():
	cek_jawaban(nilai_card2)


func _on_Card3_pressed():
	cek_jawaban(nilai_card3)

func _on_btn_main_lagi_pressed():

	get_tree().reload_current_scene()


func _on_btn_menu_pressed():

	get_tree().change_scene_to_file("res://mengenal_angka.tscn")

func _on_BtnKembali_pressed():

	AudioManager.play_click()

	get_tree().change_scene_to_file("res://mengenal_angka.tscn")
