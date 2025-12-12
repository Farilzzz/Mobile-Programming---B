import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/controller/exercise_controller.dart';
import 'package:aplikasi_gym/view/workout/list_all_exercise_page.dart';

class CategoryExercisePage extends StatelessWidget {
  final ExerciseController controller = Get.put(ExerciseController());

  final List<String> categories = [
    'chest',
    'back',
    'biceps',
    'triceps',
    'legs',
    'abdominals',
    'shoulders',
  ];

 
  CategoryExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          "All Exercise",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent, 
        elevation: 0,
        centerTitle: false, 
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String muscle = categories[index];

          return GestureDetector(
            onTap: () {
              controller.fetchExercises(muscle);
              controller.runFilter("");
              Get.to(() => ListAllExercisePage(categoryName: muscle));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 20), 
              height: 160, 
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                
                    Positioned.fill(
                      child: Image.asset(
                        controller.getImageAsset(muscle),
                        fit: BoxFit.cover, 
                        errorBuilder: (c, e, s) =>
                            Container(color: Colors.grey),
                      ),
                    ),

      
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.1), // Atas bening
                              Colors.black.withOpacity(0.8), // Bawah gelap
                            ],
                            stops: [0.4, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ),


                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Text(
                        muscle.isNotEmpty
                            ? "${muscle[0].toUpperCase()}${muscle.substring(1)}" // Capitalize first letter
                            : muscle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24, // Font gede
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
