import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/model/exercise_model.dart';
import 'package:aplikasi_gym/controller/exercise_controller.dart';
import 'package:aplikasi_gym/controller/workout_log_controller.dart'; 

class DetailExercisePage extends StatelessWidget {
  final ExerciseModel exercise;
  final ExerciseController controller = Get.find<ExerciseController>(); 
  final RxBool isExpanded = false.obs;

  DetailExercisePage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title: const Text("Detail Latihan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF00F0FF),
        label: const Text("I did this! (+Log)", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.check, color: Colors.black),
        onPressed: () {
          final logC = Get.put(WorkoutLogController());
          _showQuickLogDialog(context, logC, exercise.name);
        },
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
      
            Container(
              height: 250,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Color(0xFF2C2C2E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Image.asset(
                controller.getImageAsset(exercise.muscle),
                fit: BoxFit.contain,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
    
                  Text(
                    exercise.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  
            
                  Row(
                    children: [
                      _buildBadge(const Color(0xFF00F0FF), exercise.difficulty),
                      const SizedBox(width: 10),
                      _buildBadge(Colors.orange, exercise.equipment),
                    ],
                  ),
                  const SizedBox(height: 25),

       
                  const Text(
                    "Cara Melakukan:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  
              
                  Obx(() => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
                        Text(
                          exercise.instructions,
                          textAlign: TextAlign.justify,
                         
                          maxLines: isExpanded.value ? null : 4,
                          overflow: isExpanded.value ? TextOverflow.visible : TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            height: 1.6,
                          ),
                        ),
                        
                        const SizedBox(height: 10),
                        
                        
                        GestureDetector(
                          onTap: () => isExpanded.toggle(), 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                isExpanded.value ? "Read Less" : "Read More",
                                style: const TextStyle(
                                  color: Color(0xFF00F0FF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                isExpanded.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                color: const Color(0xFF00F0FF),
                                size: 18,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickLogDialog(BuildContext context, WorkoutLogController c, String exerciseName) {
    c.weightC.clear();
    c.repsC.clear();
    c.setsC.clear();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Log: $exerciseName", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text("Catat latihanmu untuk dapat XP!", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 20),
            
            Row(children: [
               Expanded(child: _inputField(c.weightC, "Kg")),
               const SizedBox(width: 10),
               Expanded(child: _inputField(c.repsC, "Reps")),
               const SizedBox(width: 10),
               Expanded(child: _inputField(c.setsC, "Sets")),
            ]),
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00F0FF),
                  foregroundColor: Colors.black,
                ),
                onPressed: () => c.addLog(forcedName: exerciseName), 
                child: const Text("Save & Claim XP", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _inputField(TextEditingController c, String hint) {
    return TextField(
      controller: c, 
      keyboardType: TextInputType.number, 
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint, 
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true, 
        fillColor: const Color(0xFF2C2C2E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      ),
    );
  }

  Widget _buildBadge(Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color, 
          fontWeight: FontWeight.bold, 
          fontSize: 12
        ),
      ),
    );
  }
}