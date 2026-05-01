# Tutorial 8 - Polishing and Game Balancing
#### Nama: Muhammad Farid Hasabi
#### NPM: 2306152512

## Penjelasan Proses Pengerjaan
Pada tutorial ini, saya melakukan proses *Game Polishing* dan *Game Balancing* untuk meningkatkan *Game Feel*. Berikut adalah langkah-langkah implementasi yang saya lakukan:

1. **Memperbarui Movement System:** Saya mengubah tipe data `speed` pada `Player.gd` dari `int` menjadi `float`, serta menambahkan variabel `ACCELERATION` dan `DECELERATION`. Saya menggunakan fungsi interpolasi `lerp()` pada `get_input()` untuk transisi pergerakan yang lebih mulus sehingga kecepatan (*velocity*) naik dan turun secara perlahan.
2. **Menambahkan Partikel Lari:** Saya menggunakan node `GPUParticles2D` pada *scene* pemain. Saya mengkonfigurasi `ParticleProcessMaterial` (mengatur Gravity Y ke -100, Spread ke 180, Emission Shape menjadi Box, dll) menggunakan tekstur partikel dari Kenney Assets. Partikel ini diatur agar hanya muncul (*emitting = true*) ketika kecepatan karakter menyentuh nilai maksimal dan karakter sedang berada di lantai.
3. **Balancing Spawn Rate:** Saya melakukan *Game Balancing* dengan menurunkan tingkat agresivitas rintangan pada `Spawner.gd`. Tingkat kesulitan diubah agar pemain bisa merasakan *Flow* (keseimbangan antara tantangan dan kemampuan pemain).

## Latihan Mandiri: Polishing
Menurut saya, *updated movement system* menggunakan fungsi `lerp()` beserta penambahan partikel lari (`GPUParticles2D`) sangat meningkatkan kualitas game atau *Game Feel*. Pergerakan pemain menjadi lebih halus, mulus, dan realistis karena ada efek kelembaman (*acceleration* dan *deceleration*), dibandingkan dengan pergerakan konstan sebelumnya yang terasa kaku. Partikel debu atau *trail* yang muncul juga memberikan isyarat visual (*visual feedback*) yang jelas bagi pemain saat karakter berlari dengan kecepatan penuh, membuat permainan terasa jauh lebih reaktif dan *juicy*.

## Latihan Mandiri: Game Balancing
Pada tahap *game balancing*, nilai **Spawn Rate** dari `Enemy Spawner` (*Timer*) yang sebelumnya `0.5` detik membuat game menjadi sangat sulit atau hampir mustahil untuk diselesaikan (*Unbalanced/Rage-inducing*). Setelah bereksperimen, saya mengubah nilai *spawn rate* menjadi `3.0` detik. Nilai `3.0` detik ini memberikan pemain cukup jeda waktu untuk menghindari rintangan, mengatur *timing* pergerakan menuju akhir level tanpa kehilangan tingkat tantangan, sehingga pemain dapat bermain dengan nyaman di dalam batas *Flow*.

## Referensi Tambahan
* [Godot Docs: Interpolation (lerp)](https://docs.godotengine.org/en/stable/tutorials/math/interpolation.html)
* [Godot Docs: GPUParticles2D](https://docs.godotengine.org/en/stable/classes/class_gpuparticles2d.html)

---

# Tutorial 6 - Menu and In-Game GUI
####  Nama: Muhammad Farid Hasabi
#### NPM : 2306152512

## Implementasi UI (Tutorial 6 & Latihan Mandiri)
Sistem antarmuka pengguna telah diintegrasikan untuk memberikan pengalaman bermain yang utuh (*game loop*):
* **Main Menu:** Dilengkapi dengan judul dan sistem navigasi menu.
* **Stage Select:** Layar transisi dinamis yang memanfaatkan susunan `VBoxContainer` dan `HBoxContainer` agar pemain dapat melompat langsung ke Level 1 atau Level 2.
* **Global Life Counter:** Indikator sisa nyawa player yang persisten selama *gameplay*, ditampilkan menggunakan `CanvasLayer` agar terpisah dari kamera karakter utama.
* **Game Over & Win Screen:** Layar akhir permainan yang interaktif. Jika nyawa pemain menyentuh angka `<= 0`, layar Game Over akan muncul. Jika pemain mencapai win area/objective, maka layar Win Screen akan muncul dan menampilkan kalkulasi sisa nyawa saat itu.

## Fitur Tambahan
Selain fitur wajib diatas, saya juga menambahkan fitur-fitur lainnya, antara lain:

###  Arsitektur Singleton (Autoload)
* **Global State (`Global.gd`):** Menggunakan sistem *Globals/Autoload* untuk menyimpan variabel `lives = 3`. Terdapat logika *auto-reset* yang akan mengembalikan nyawa menjadi penuh setiap kali pemain menekan tombol *New Game*, menekan tombol kembali ke *Main Menu*, atau ketika berhasil memenangkan suatu level.
* **Scene Transition Manager (`TransitionScreen.tscn`):** Alih-alih memindahkan *scene* secara kasar (*hard cut*), perpindahan level ditangani oleh sebuah Autoload berLayer 10 yang berisi `ColorRect` dan `AnimationPlayer`. Menggunakan kombinasi *method* `await`, sistem menyajikan transisi layar *Fade to Black* dan *Fade to Normal* yang mulus antar level.

### Dynamic Pause Menu
* Mengimplementasikan menu Pause berbasis `ui_cancel` (ESC).
* **Pause State Mastery:** *Node* menu Pause diatur Process Mode-nya menjadi `Always`, sementara sistem *gameplay* dibekukan menggunakan `get_tree().paused = true`. 
* **Perbaikan Timer:** Menangani *bug* klasik di mana *spawner* rintangan terus menumpuk objek saat game di-pause dengan cara menerapkan parameter `false` pada `get_tree().create_timer(time, process_always)` dan mengatur mode Process pada node Timer menjadi `Pausable` / `Inherit`.

## Referensi Tambahan
* [Godot Docs: Singletons (Autoload)](https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html)
* [Godot Docs: Pausing games](https://docs.godotengine.org/en/stable/tutorials/scripting/pausing_games.html)
* [Godot Docs: Method call_deferred()](https://docs.godotengine.org/en/stable/classes/class_object.html#class-object-method-call-deferred)

---
# Tutorial 4 - Basic 2D Level Design
####  Nama: Muhammad Farid Hasabi
#### NPM : 2306152512
---

# Latihan Mandiri

## Implementasi Kebutuhan Minimum

Disini saya telah mengimplementasikan beberapa kebutuhan minimum, antara lain: 

* **TileMap Berbeda:** Pada Level 2 kali ini, saya menggunakan aset *tileset* yang berbeda dari Level 1 (menggunakan variasi *sand* dan *snow*). *TileMapLayer* dikonfigurasi secara manual agar tidak terjadi konflik *physics layer* (kolisi) dengan level sebelumnya.
* **Spawner Rintangan Baru:** Menggunakan `Marker2D` dan `Timer` sebagai *Universal Spawner*. Terdapat dua jenis rintangan baru selain FallingFish:
	* **Bomb menggunakan RigidBody2D:** Rintangan yang jatuh bebas secara vertikal dipengaruhi oleh gravitasi mesin fisika Godot secara periodik.
	* **Bird menggunakan RigidBody2D:** Rintangan proyektil yang muncul dan bergerak cepat secara horizontal melintasi layar. Posisi *spawn* sumbu Y diatur secara acak menggunakan `randf_range(0.0, 300.0)` agar pergerakkan tidak mudah ditebak.
* **Jurang & Rintangan Periodik:** Level didesain dengan beberapa celah jurang yang dipasangi `LoseArea` di bagian bawah. Objek rintangan seperti Bomb dan Bird juga di-*spawn* secara periodik menggunakan sinyal `timeout` dari *node* Timer yang di-set ke *Autostart*.

---

## Fitur Tambahan

Saya juga menambahkan beberpaa fitur tambahan lain untuk meningkatkan *experience* player yang memainkannya. 

### Environment Mechanics
* **Lantai Salju Licin (Ice Physics):** Saya mengimplementasikannya menggunakan `Area2D` (*Snow Zone*). Saat pemain memasuki area ini, *script* akan mengubah properti `friction` (gesekan) dan `acceleration` pada `CharacterBody2D` pemain secara drastis. Fungsi pergerakan pemain dirombak menggunakan `move_toward()` agar momentum karakter tetap terjaga, seta menciptakan efek meluncur yang terasa realistis.
* **Jebakan Instan (Spikes):** Area statis menggunakan `Area2D` yang akan langsung mereset *scene* jika disentuh pemain.

### Enemy Slime
Terdapat entitas musuh statis dinamis (Slime) yang melakukan patroli secara otonom dengan logika berikut:
* Bergerak secara horizontal menggunakan `position.x`.
* Dilengkapi dengan **Sensor Peraba Tembok (RayCast2D)**. Jika *RayCast* mendeteksi *Collision Layer* milik *TileMap*, musuh akan berhenti dan akan berputar balik.
* Menggunakan *Timer* internal untuk bertransisi ke state **Idle** (memutar animasi diam sejenak) sebelum akhirnya membalikkan arah (*flip_h*) dan melanjutkan patroli ke arah sebaliknya.

---
## Referensi

* **Godot Engine Documentation:**
	* [https://docs.godotengine.org/en/stable/classes/class_rigidbody2d.html](https://docs.godotengine.org/en/stable/classes/class_rigidbody2d.html) - Digunakan untuk manipulasi `linear_velocity` pada Bomb dan Bird.
	* [https://docs.godotengine.org/en/stable/classes/class_raycast2d.html](https://docs.godotengine.org/en/stable/classes/class_raycast2d.html) - Digunakan untuk deteksi blok pada Slime.
