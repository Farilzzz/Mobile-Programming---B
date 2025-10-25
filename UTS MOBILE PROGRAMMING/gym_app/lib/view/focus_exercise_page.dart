import 'package:flutter/material.dart';
import 'package:get/get.dart'; // <-- 1. Import GetX

// Ganti 'nama_proyek_anda' dengan nama proyek Anda
import 'package:gym_app/controller/exercise_controller.dart'; // <-- 2. Import Controller
import 'package:gym_app/model/dummy_model.dart'; // <-- 3. Import Model
import 'package:gym_app/view/list_all_exercise_page.dart'; // <-- Halaman selanjutnya

class FocusExercisePage extends StatelessWidget {
  const FocusExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 4. Inisialisasi "Koki" (Controller)
    //    Get.put() akan membuat instance baru, atau menemukan yg sudah ada.
    final ExerciseController controller = Get.put(ExerciseController());

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "All Exercise",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // 5. Bungkus body dengan Obx()
      //    Obx() akan "mendengarkan" perubahan data di controller
      body: Obx(() {
        // 6. Tampilkan loading jika data sedang dimuat
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        }

        // 7. Ganti ListView hardcode menjadi ListView.builder dinamis
        return ListView.builder(
          itemCount: controller.bodyPartList.length, // Jumlah item dari controller
          itemBuilder: (context, index) {
            // Ambil data 1 BodyPart dari controller
            final BodyPart bodyPart = controller.bodyPartList[index];
            
            // Panggil helper widget kita dengan data dinamis
            return _buildBodyPartCard(
              context: context,
              title: bodyPart.name,
              imagePath: bodyPart.imagePath,
              onTap: () {
                // Navigasi ke Halaman 3 (List Latihan)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // 8. Kirim SELURUH list 'exercises' dari BodyPart yg dipilih
                    builder: (_) => ListAllExercisePage(
                      bodyPartName: bodyPart.name,
                      exercises: bodyPart.exercises,
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }

  /// Helper untuk Kartu Kategori Bagian Tubuh
  Widget _buildBodyPartCard({
    required BuildContext context,
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {},
          ),
          color: const Color(0xFF2C1C1E), // Warna fallback
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.center,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
