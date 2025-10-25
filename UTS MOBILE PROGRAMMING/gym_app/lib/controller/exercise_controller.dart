// File: exercise_controller.dart
// Lokasi: lib/controller/
// Fungsi: Si "Koki" yang memasak data dari JSON untuk disajikan ke View.

import 'dart:convert'; // Untuk json.decode
import 'package:flutter/services.dart'; // Untuk rootBundle (baca file assets)
import 'package:get/get.dart';

// 1. Import "cetakan" data kita dari folder model
// GANTI 'nama_proyek_anda' dengan nama proyek Anda
import 'package:gym_app/model/dummy_model.dart';

class ExerciseController extends GetxController {
  // --- STATE (Data Reaktif) ---

  // .obs membuat variabel ini menjadi "reaktif"
  // Artinya, jika data ini berubah, GetX akan otomatis update UI.
  var bodyPartList = <BodyPart>[].obs;

  // Variabel untuk status loading
  var isLoading = true.obs;

  // --- LOGIC (Fungsi) ---

  @override
  void onInit() {
    super.onInit();
    // Saat Controller ini pertama kali hidup,
    // langsung panggil fungsi untuk muat data.
    loadExerciseData();
  }

  // Fungsi asinkron untuk memuat data dari JSON
  Future<void> loadExerciseData() async {
    try {
      // 1. Set status jadi loading
      isLoading.value = true;

      // 2. Baca file JSON mentah dari assets
      final String jsonString = await rootBundle.loadString(
        'assets/data/dummy_gym_app.json',
      );

      // 3. Ubah JSON (String) menjadi List<dynamic>
      final List<dynamic> jsonData = json.decode(jsonString);

      // 4. Ubah setiap item di list JSON menjadi objek BodyPart
      //    (menggunakan 'cetakan' .fromJson dari dummy_model.dart)
      bodyPartList.value = jsonData
          .map((item) => BodyPart.fromJson(item))
          .toList();
    } catch (e) {
      // Jika ada error (file tidak ketemu, format salah, dll)
      print("Error memuat data latihan: $e");
    } finally {
      // 5. Selesai loading (baik berhasil maupun gagal)
      isLoading.value = false;
    }
  }
}
