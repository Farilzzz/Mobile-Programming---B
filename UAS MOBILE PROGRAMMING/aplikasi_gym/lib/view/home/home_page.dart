import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/controller/auth_controller.dart'; 
import 'package:aplikasi_gym/view/profile_page.dart';
import 'package:aplikasi_gym/view/workout/category_exercise_page.dart';
import 'package:aplikasi_gym/view/workout/workout_log_page.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
    
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                        final userName = authC.currentUser.value?.fullName ?? "GYM BRO";
                        return Text(
                          "HELLO ${userName.toUpperCase()}",
                          style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
                        );
                      }
                    ),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const ProfilePage()),
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFF00F0FF),
                    child: Icon(Icons.person, color: Colors.black, size: 30),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            Obx(() {
              final user = authC.currentUser.value;
              if (user == null) return const SizedBox();

              double progress = (user.currentXp / user.maxXp).clamp(0.0, 1.0);

              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF2C2C2E), const Color(0xFF000000)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF00F0FF).withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("LEVEL: ${user.level.toUpperCase()}", 
                          style: const TextStyle(color: Color(0xFF00F0FF), fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("${user.currentXp} / ${user.maxXp} XP", 
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10),
                 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: Colors.grey[800],
                        color: const Color(0xFF00F0FF),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Keep pushing! You need ${user.maxXp - user.currentXp} XP more to level up.",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              );
            }),
            
            const SizedBox(height: 30),

          
            Text(
              "Start Your Training",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

        
            _buildMenuCard(
              "All Exercise & Recipes",
              Icons.fitness_center,
              () => Get.to(() => CategoryExercisePage()),
            ),

          
            _buildMenuCard(
              "Workout History & Logs",
              Icons.history,
              () => Get.to(() => const WorkoutLogPage()), 
            ),

         
            _buildMenuCard(
              "Health Tips",
              Icons.healing,
              () => Get.snackbar("Info", "Coming Soon!"),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),

   
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
             Get.to(() => const WorkoutLogPage());
          } else if (index == 2) {
             Get.to(() => const ProfilePage());
          }
        },
        backgroundColor: const Color(0xFF1C1C1E),
        selectedItemColor: const Color(0xFF00F0FF),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "History"), 
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100, 
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF2C2C2E),
          border: Border.all(color: Colors.white10),
        ),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00F0FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Icon(icon, size: 30, color: const Color(0xFF00F0FF)),
                ),
                const SizedBox(width: 20),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}