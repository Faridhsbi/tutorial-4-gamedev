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
