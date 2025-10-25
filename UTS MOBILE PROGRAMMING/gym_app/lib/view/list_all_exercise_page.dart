import 'package:flutter/material.dart';
// Ganti 'nama_proyek_anda' dengan nama proyek Anda
import 'package:gym_app/model/dummy_model.dart'; // <-- 1. Import Model
import 'package:gym_app/view/detail_exercise_page.dart'; // <-- Halaman selanjutnya

class ListAllExercisePage extends StatelessWidget {
  // 2. Siapkan "Pintu" untuk menerima data
  final String bodyPartName;
  final List<Exercise> exercises;

  // 3. Buat Constructor-nya
  const ListAllExercisePage({
    super.key,
    required this.bodyPartName,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
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
        // 4. Gunakan data yang diterima di Judul
        title: Text(
          bodyPartName,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // 5. Gunakan data yang diterima di Body
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final Exercise exercise = exercises[index];
          
          return _buildExerciseItem(
            context: context,
            exercise: exercise, // Kirim data ke helper
            onTap: () {
              // 6. Kirim data 1 latihan ke halaman detail
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailExercisePage(exercise: exercise),
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// Helper untuk SATU item latihan (sekarang menerima Objek Exercise)
  Widget _buildExerciseItem({
    required BuildContext context,
    required Exercise exercise,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(exercise.imagePath), // <-- Data dinamis
                  fit: BoxFit.cover,
                  onError: (e, s) {},
                ),
                color: const Color(0xFF2C2C2E),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name, // <-- Data dinamis
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    exercise.info, // <-- Data dinamis
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white, size: 28),
          ],
        ),
      ),
    );
  }
}
