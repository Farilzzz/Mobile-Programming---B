import 'package:flutter/material.dart';
// Ganti 'nama_proyek_anda' dengan nama proyek Anda
import 'package:gym_app/model/dummy_model.dart'; // <-- 1. Import Model

class DetailExercisePage extends StatelessWidget {
  // 2. Siapkan "Pintu" untuk menerima data 1 latihan
  final Exercise exercise;

  // 3. Buat Constructor-nya
  const DetailExercisePage({
    super.key,
    required this.exercise,
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 4. Gunakan Data Dinamis di Header ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(exercise.imagePath), // <-- Data
                      fit: BoxFit.cover,
                      onError: (e, s) {},
                    ),
                    color: const Color(0xFF2C2C2E),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    exercise.name, // <-- Data
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // --- 5. Gunakan Data Dinamis di Konten ---
            _buildSection(
              title: "Description",
              content: exercise.description, // <-- Data
            ),
            _buildSection(
              title: "Target Muscles",
              content: exercise.targetMuscles, // <-- Data
            ),
            _buildSection(
              title: "Preparation and Execution",
              content: exercise.preparation, // <-- Data
            ),
          ],
        ),
      ),
    );
  }

  /// Helper widget untuk satu seksi
  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title :",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
