import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/controller/exercise_controller.dart';
import 'package:aplikasi_gym/view/workout/detail_exercise_page.dart';

class ListAllExercisePage extends StatelessWidget {
  final String categoryName;
  final ExerciseController controller = Get.find<ExerciseController>();

  ListAllExercisePage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E), 
      appBar: AppBar(
        title: Text(
          categoryName.toUpperCase(),
          style: const TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: const Color(0xFF00F0FF), 
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        children: [
          // === FITUR SEARCH BAR ===
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF1C1C1E), 
            child: TextField(
              onChanged: (value) => controller.runFilter(value),
              style: const TextStyle(color: Colors.white), 
              decoration: InputDecoration(
                hintText: "Cari latihan...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF00F0FF)),
                filled: true,
                fillColor: const Color(0xFF2C2C2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              ),
            ),
          ),

          // === LIST DATA ===
          Expanded(
            child: Obx(() {
             
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator(color: Color(0xFF00F0FF)));
              }

              
              if (controller.isSearching.value) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Color(0xFF00F0FF)),
                      SizedBox(height: 15),
                      Text("Mencari...", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                );
              }

             
              if (controller.filteredList.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text("Latihan tidak ditemukan.", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                );
              }

            
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: controller.filteredList.length,
                itemBuilder: (context, index) {
                  final item = controller.filteredList[index];
                  return Card(
                    color: const Color(0xFF2C2C2E), 
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: Container(
                        width: 60, height: 60,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          controller.getImageAsset(categoryName),
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      subtitle: Text("Level: ${item.difficulty}", style: const TextStyle(color: Color(0xFF00F0FF))),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      onTap: () {
                        Get.to(() => DetailExercisePage(exercise: item));
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}